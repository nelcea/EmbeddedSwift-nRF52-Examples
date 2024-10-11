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

/**
 * @typedef gpio_callback_handler_t
 * @brief Define the application callback handler function signature
 *
 * @param port Device struct for the GPIO device.
 * @param cb Original struct gpio_callback owning this handler
 * @param pins Mask of pins that triggers the callback handler
 *
 * Note: cb pointer can be used to retrieve private data through
 * CONTAINER_OF() if original struct gpio_callback is stored in
 * another private structure.
 */
 /*
typedef void (*gpio_callback_handler_t)(const struct device *port,
					struct gpio_callback *cb,
					gpio_port_pins_t pins);
*/

typealias GpioCallbackHandler = @convention(c) (
  _ port: UnsafePointer<device>?,
  _ callback: UnsafeMutablePointer<gpio_callback>?,
  _ pins: UInt32
) -> Void

/**
 * @brief Unsigned integer with bit position @p n set (signed in
 * assembly language).
 */
 // #define BIT(n)  (1UL << (n))
func bit(_ n: UInt8) -> UInt32 {
  UInt32(1) << n
}

@main
struct Main {
  static func main() {
    let myButton = Button(gpio: &button) { _, _, _ in
      print("Button pressed")
    }

    while true {
      k_msleep(100)
    }
  }
}

class Button {
  let gpio: UnsafePointer<gpio_dt_spec>
  let btnHandler: GpioCallbackHandler
  var pin_cb_data = gpio_callback()

  init(gpio: UnsafePointer<gpio_dt_spec>, btnHandler: GpioCallbackHandler) {
    self.gpio = gpio
    self.btnHandler = btnHandler

    guard gpio_is_ready_dt(gpio) else { return }

    let ret = gpio_pin_configure_dt(gpio, GPIO_INPUT)
    guard ret == 0 else { return }

    gpio_pin_interrupt_configure_dt(gpio, GpioInterrupts.edgeToActive)

    gpio_init_callback(&pin_cb_data, self.btnHandler, bit(gpio.pointee.pin))

    gpio_add_callback(gpio.pointee.port, &pin_cb_data)
  }
}