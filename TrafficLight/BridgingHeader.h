//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift open source project
//
// Copyright (c) 2023 Apple Inc. and the Swift project authors.
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

#include <autoconf.h>

#include <zephyr/kernel.h>
#include <zephyr/drivers/gpio.h>

#define GREEN_LED_NODE DT_ALIAS(greenled)
static struct gpio_dt_spec greenled = GPIO_DT_SPEC_GET(GREEN_LED_NODE, gpios);

#define YELLOW_LED_NODE DT_ALIAS(yellowled)
static struct gpio_dt_spec yellowled = GPIO_DT_SPEC_GET(YELLOW_LED_NODE, gpios);

#define RED_LED_NODE DT_ALIAS(redled)
static struct gpio_dt_spec redled = GPIO_DT_SPEC_GET(RED_LED_NODE, gpios);


#define SW0_NODE DT_ALIAS(sw0)
static struct gpio_dt_spec button = GPIO_DT_SPEC_GET(SW0_NODE, gpios);

struct extended_callback {
	struct gpio_callback pin_cb_data;
    void *context;
};

static inline struct extended_callback *container_of(struct gpio_callback *ptr)
{
    return ((struct extended_callback *)(((char *)(ptr)) - offsetof(struct extended_callback, pin_cb_data)));
}