#include <stdio.h>
#include <zephyr/drivers/gpio.h>
#include "button.h"

#define SW0_NODE DT_ALIAS(sw0)
static struct gpio_dt_spec button = GPIO_DT_SPEC_GET(SW0_NODE, gpios);

static struct gpio_callback pin_cb_data;

void setupButton() {
  int ret;

  if (!gpio_is_ready_dt(&button)) {
    return;
  }

  ret = gpio_pin_configure_dt(&button, GPIO_INPUT);
  if (ret < 0) {
    return;
  }

  gpio_pin_interrupt_configure_dt(&button, GPIO_INT_EDGE_TO_ACTIVE);

  void pin_isr(const struct device *dev, struct gpio_callback *cb, uint32_t pins) {
    printk("Button pressed\n");
  }

  gpio_init_callback(&pin_cb_data, pin_isr, BIT(button.pin));

  gpio_add_callback(button.port, &pin_cb_data);
}