char const*const LCD_FILE		= "/sys/devices/i2c-0/0-0036/leds/lm3533-lcd-bl/brightness";
char const*const LCD2_FILE		= "/dev/null";
char const*const RED_LED_FILE		= "/sys/devices/i2c-0/0-0036/leds/lm3533-red/brightness";
char const*const GREEN_LED_FILE		= "/sys/devices/i2c-0/0-0036/leds/lm3533-green/brightness";
char const*const BLUE_LED_FILE		= "/sys/devices/i2c-0/0-0036/leds/lm3533-blue/brightness";
char const*const SYNC_LVBANKS		= "/sys/devices/i2c-0/0-0036/sync_lvbanks";

char const*const LED_FILE_PATTERN[]	= {
					  "/sys/devices/i2c-0/0-0036/leds/lm3533-red/pattern",
					  "/sys/devices/i2c-0/0-0036/leds/lm3533-green/pattern",
					  "/sys/devices/i2c-0/0-0036/leds/lm3533-blue/pattern",
					  };

char const*const PATTERNOFF		= "0,0,0,0";


