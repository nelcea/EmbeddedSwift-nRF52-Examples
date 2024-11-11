enum GpioInterrupts {
  static let edgeToActive = GPIO_INT_ENABLE | GPIO_INT_LEVELS_LOGICAL | GPIO_INT_EDGE | GPIO_INT_HIGH_1
}

func bit(_ n: UInt8) -> UInt32 {
  UInt32(1) << n
}

typealias GpioCallbackHandler = @convention(c) (
  _ port: UnsafePointer<device>?,
  _ callback: UnsafeMutablePointer<gpio_callback>?,
  _ pins: UInt32
) -> Void

// See https://www.ericbariaux.com/posts/button_embedded_swift_nrf52_part2/ for explanation of extended callback mechanism
struct ExtendedCallback<T> {
  var callback: gpio_callback
  var context: T

  static func containerFrom(callback ptr: UnsafePointer<gpio_callback>) -> ExtendedCallback {
    let containerPtr = UnsafeRawPointer(ptr) - MemoryLayout.offset(of: \Self.callback)!
    return containerPtr.assumingMemoryBound(to: Self.self).pointee
  }
}

struct Button<T> {
  var gpio: UnsafePointer<gpio_dt_spec>
  var handle: GpioCallbackHandler?
  var pin_cb_data: UnsafeMutablePointer<ExtendedCallback<T>>

  init(gpio: UnsafePointer<gpio_dt_spec>, context: T, handle: GpioCallbackHandler?) {
   	if (!gpio_is_ready_dt(gpio)) {
  		fatalError("Button init error, GPIO not ready")
	  }

    self.gpio = gpio
    self.pin_cb_data = UnsafeMutablePointer<ExtendedCallback<T>>.allocate(capacity: 1)

    self.pin_cb_data.pointee.callback = gpio_callback()
    self.pin_cb_data.pointee.context = context
    self.handle = handle

    var ret = gpio_pin_configure_dt(self.gpio, GPIO_INPUT)
    if ret < 0 {
      fatalError("Button init error, configure pin failed")
    }

    ret = gpio_pin_interrupt_configure_dt(gpio, GpioInterrupts.edgeToActive)
    if ret < 0 {
      fatalError("Button init error, configure interrupt failed")
    }

	  gpio_init_callback(&self.pin_cb_data.pointee.callback, self.handle, bit(gpio.pointee.pin))

	  ret = gpio_add_callback(self.gpio.pointee.port, &self.pin_cb_data.pointee.callback)

    if ret < 0 {
      fatalError("Button init error, configure calback failed")
    }
  }
}