@main
struct Main {
  static func main() {
    let led = Led(gpio: &led0)

    let timer = Timer<Led>.scheduledTimer(userData: led, delay: 5000, period: 2000) { timer in
      Timer<Led>.getUserData(timer).toggle()
    }

    while true {
      k_msleep(5000)
    }
  }
}

typealias TimerExpiry = @convention(c) (
  _ timer: UnsafeMutablePointer<k_timer>?
) -> Void

struct Timer<T: AnyObject>: ~Copyable {
  var timer = UnsafeMutablePointer<k_timer>.allocate(capacity: 1)
  var delay: UInt32
  var period: UInt32?
  var userData: T

  static func scheduledTimer(userData: T, delay: UInt32, period: UInt32? = nil, handler: TimerExpiry?) -> Timer {
    let t = Timer(userData: userData, delay: delay, period: period, handler: handler)
    t.start()
    return t
  }

  init(userData: T, delay: UInt32, period: UInt32? = nil, handler: TimerExpiry?) {
    self.delay = delay
    self.period = period

    k_timer_init(timer, handler, nil)

    self.userData = userData
    timer.pointee.user_data = Unmanaged.passUnretained(userData).toOpaque()
  }

  deinit {
    k_timer_stop(timer)
    timer.deallocate()
  }

  func start() {
    k_timer_start(timer, msToTImeout(self.delay), msToTImeout(self.period == nil ? 0 : self.period!))
  }

  static func getUserData(_ timer: UnsafeMutablePointer<k_timer>?) -> T {
    return Unmanaged.fromOpaque(timer!.pointee.user_data).takeUnretainedValue()
  }

  private func msToTImeout(_ delay: UInt32) -> k_timeout_t {
    k_timeout_t(ticks: msToTick(delay))
  }

  private func msToTick(_ delay: UInt32) -> Int64 {
    return Int64((Double(UInt64(CONFIG_SYS_CLOCK_TICKS_PER_SEC) * UInt64(delay)) / 1000.0).rounded(.up))
  }
}

class Led {
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