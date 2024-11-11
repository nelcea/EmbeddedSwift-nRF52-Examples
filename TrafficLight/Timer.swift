typealias TimerExpiry = @convention(c) (
  _ timer: UnsafeMutablePointer<k_timer>?
) -> Void

struct Timer<T: AnyObject> : ~Copyable {
  var timer = UnsafeMutablePointer<k_timer>.allocate(capacity: 1)
  var handle: TimerExpiry?

  var userData: T

  init(userData: T, delay: Int32, handle: TimerExpiry?) {
    k_timer_init(timer, handle, nil)
    self.userData = userData
    // We're already retaining userData through the stored property, no need to do it twice
    timer.pointee.user_data = Unmanaged.passUnretained(userData).toOpaque()

    k_timer_start(timer, k_timeout_t(ticks: msToTick(delay)), k_timeout_t(ticks: 0))
  }
  // Non copyable gives us the deinit where we can clean-up the underlying timer
  deinit {
    k_timer_stop(timer)
    timer.deallocate()
  }

  static func getUserData(_ timer: UnsafeMutablePointer<k_timer>?) -> T {
      return Unmanaged.fromOpaque(timer!.pointee.user_data).takeUnretainedValue()
  }

  // Swift C Interop can't handle the K_MSEC / Z_TIMEOUT_MS macros, have simple conversion function
  private func msToTick(_ delay: Int32) -> Int64 {
    return Int64(CONFIG_SYS_CLOCK_TICKS_PER_SEC) * Int64(delay) / 1000
  }
}