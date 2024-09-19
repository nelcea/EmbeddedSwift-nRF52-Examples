@main
struct Main {
  static func main() {
    guard gpio_is_ready_dt(&button) else { return }

    let ret = gpio_pin_configure_dt(&button, GPIO_INPUT)
    guard ret == 0 else { return }

    while true {
      k_msleep(100)
    }
  }
}