/*
 * Copyright (C) 2013 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <dirent.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdbool.h>

#define LOG_NDEBUG 0

#define LOG_TAG "YugaPowerHAL"
#include <utils/Log.h>

#include <hardware/hardware.h>
#include <hardware/power.h>

#define BOOSTPULSE_PATH "/sys/devices/system/cpu/cpufreq/interactive/boostpulse"
#define BOOSTPULSE_SKIP_SECONDS 30

struct yuga_power_module {
    struct power_module base;
    pthread_mutex_t lock;
    int boostpulse_fd;
    time_t noop_until;
};

static bool low_power_mode = false;

static void sysfs_write(const char *path, char *s)
{
    char buf[80];
    int len;
    int fd = open(path, O_WRONLY);

    if (fd < 0) {
        strerror_r(errno, buf, sizeof(buf));
        ALOGE("Error opening %s: %s\n", path, buf);
        return;
    }

    len = write(fd, s, strlen(s));
    if (len < 0) {
        strerror_r(errno, buf, sizeof(buf));
        ALOGE("Error writing to %s: %s\n", path, buf);
    }

    close(fd);
}

static void power_init(struct power_module __unused *module)
{
    // handled by qcfqd
}

static void power_set_interactive(struct power_module __unused *module, int on __unused)
{
    // handled by qcfqd
}

static int boostpulse_open(struct yuga_power_module *ypMod)
{
    char buf[80];
    int len;
    time_t nowtime;

    pthread_mutex_lock(&ypMod->lock);

    if (ypMod->boostpulse_fd < 0) {
        time(&nowtime);
        if (nowtime > ypMod->noop_until) {
            ypMod->boostpulse_fd = open(BOOSTPULSE_PATH, O_WRONLY);
            if (ypMod->boostpulse_fd < 0) {
                strerror_r(errno, buf, sizeof(buf));
                time(&ypMod->noop_until);
                ypMod->noop_until += BOOSTPULSE_SKIP_SECONDS;
                ALOGE("Error opening %s: %s, ignoring until %lu\n", BOOSTPULSE_PATH, buf, ypMod->noop_until);
            }
        }
    }

    pthread_mutex_unlock(&ypMod->lock);
    return ypMod->boostpulse_fd;
}

static void boostpulse_close(struct yuga_power_module *ypMod)
{
    pthread_mutex_lock(&ypMod->lock);

    if (ypMod->boostpulse_fd >= 0) {
        close(ypMod->boostpulse_fd);
        ypMod->boostpulse_fd = -1;
    }

    pthread_mutex_unlock(&ypMod->lock);

}

static void yuga_power_hint(struct power_module *module, power_hint_t hint,
                                void *data __unused)
{
    struct yuga_power_module *ypMod =
            (struct yuga_power_module *) module;
    char buf[80];
    int len;

    switch (hint) {
     case POWER_HINT_INTERACTION:
        if (boostpulse_open(ypMod) >= 0) {
            len = write(ypMod->boostpulse_fd, "1", 1);

            if (len < 0) {
                strerror_r(errno, buf, sizeof(buf));
                ALOGE("Error writing to %s: %s\n", BOOSTPULSE_PATH, buf);
                boostpulse_close(ypMod);
            }
        }

        break;

   case POWER_HINT_VSYNC:
        break;

    default:
            break;
    }
}

static struct hw_module_methods_t power_module_methods = {
    .open = NULL,
};

struct yuga_power_module HAL_MODULE_INFO_SYM = {
    base: {
        common: {
            tag: HARDWARE_MODULE_TAG,
            module_api_version: POWER_MODULE_API_VERSION_0_2,
            hal_api_version: HARDWARE_HAL_API_VERSION,
            id: POWER_HARDWARE_MODULE_ID,
            name: "AOSP Yuga Power HAL",
            author: "The Android Open Source Project",
            methods: &power_module_methods,
        },

        init: power_init,
        setInteractive: power_set_interactive,
        powerHint: yuga_power_hint,
    },

    lock: PTHREAD_MUTEX_INITIALIZER,
    boostpulse_fd: -1,
    noop_until: 0,
};

