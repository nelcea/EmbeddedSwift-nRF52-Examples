@main
struct Main {
  static func main() {
    guard gpio_is_ready_dt(&button) else { return }

    while true {
      k_msleep(100)
    }
  }
}