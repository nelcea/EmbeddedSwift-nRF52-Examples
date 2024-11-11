struct Led {
  var gpio: UnsafePointer<gpio_dt_spec>

  init(gpio: UnsafePointer<gpio_dt_spec>) {
   	if (!gpio_is_ready_dt(gpio)) {
  		fatalError("LED init error, GPIO not ready")
	  }

    self.gpio = gpio
    gpio_pin_configure_dt(gpio, GPIO_OUTPUT | GPIO_OUTPUT_INIT_HIGH | GPIO_OUTPUT_INIT_LOGICAL)
  }

  func on() {
    gpio_pin_set_dt(gpio, 1)
  }

  func off() {
    gpio_pin_set_dt(gpio, 0)
  }

  func toggle() {
    gpio_pin_toggle_dt(gpio)
  }
}