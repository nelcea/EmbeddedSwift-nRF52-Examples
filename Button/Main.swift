/** Configures GPIO interrupt to be triggered on pin state change to logical
 * level 1 and enables it.
 */
 /*
#define GPIO_INT_EDGE_TO_ACTIVE        (GPIO_INT_ENABLE | \
					GPIO_INT_LEVELS_LOGICAL | \
					GPIO_INT_EDGE | \
					GPIO_INT_HIGH_1)
*/
enum GpioInterrupts {
  static let edgeToActive = GPIO_INT_ENABLE | GPIO_INT_LEVELS_LOGICAL | GPIO_INT_EDGE | GPIO_INT_HIGH_1
}

@main
struct Main {
  static func main() {
    guard gpio_is_ready_dt(&button) else { return }

    let ret = gpio_pin_configure_dt(&button, GPIO_INPUT)
    guard ret == 0 else { return }

    gpio_pin_interrupt_configure_dt(&button, GpioInterrupts.edgeToActive)

    while true {
      k_msleep(100)
    }
  }
}