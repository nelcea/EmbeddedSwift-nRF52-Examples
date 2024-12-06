@main
struct Main {
  static func main() {
    let timer1 = Timer.scheduledTimer(delay: 10000) { timer in
      print("10 seconds have elapsed")    
    }
    let timer2 = Timer.scheduledTimer(delay: 5000, period: 2000) { timer in
      print("Ticking every 2 seconds")
    }
    while true {
      k_msleep(5000)
    }
  }
}

typealias TimerExpiry = @convention(c) (
  _ timer: UnsafeMutablePointer<k_timer>?
) -> Void

struct Timer: ~Copyable {
  var timer = UnsafeMutablePointer<k_timer>.allocate(capacity: 1)
  var delay: UInt32
  var period: UInt32?

  static func scheduledTimer(delay: UInt32, period: UInt32? = nil, handler: TimerExpiry?) -> Timer {
    let t = Timer(delay: delay, period: period, handler: handler)
    t.start()
    return t
  }

  init(delay: UInt32, period: UInt32? = nil, handler: TimerExpiry?) {
    self.delay = delay
    self.period = period
    k_timer_init(timer, handler, nil)
  }

  deinit {
    k_timer_stop(timer)
    timer.deallocate()
  }

  func start() {
    k_timer_start(timer, msToTImeout(self.delay), msToTImeout(self.period == nil ? 0 : self.period!))
  }

  private func msToTImeout(_ delay: UInt32) -> k_timeout_t {
    k_timeout_t(ticks: msToTick(delay))
  }

  private func msToTick(_ delay: UInt32) -> Int64 {
    return Int64((Double(UInt64(CONFIG_SYS_CLOCK_TICKS_PER_SEC) * UInt64(delay)) / 1000.0).rounded(.up))
  }
}