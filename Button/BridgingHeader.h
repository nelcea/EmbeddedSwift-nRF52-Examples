#include <autoconf.h>
#include <zephyr/kernel.h>
#include <zephyr/drivers/gpio.h>

#define SW0_NODE DT_ALIAS(sw0)
static struct gpio_dt_spec button = GPIO_DT_SPEC_GET(SW0_NODE, gpios);
