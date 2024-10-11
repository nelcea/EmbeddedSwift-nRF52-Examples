#include <autoconf.h>
#include <zephyr/kernel.h>
#include <zephyr/drivers/gpio.h>

#define LED0_NODE DT_ALIAS(led0)
static struct gpio_dt_spec led0 = GPIO_DT_SPEC_GET(LED0_NODE, gpios);

#define SW0_NODE DT_ALIAS(sw0)
static struct gpio_dt_spec button = GPIO_DT_SPEC_GET(SW0_NODE, gpios);
