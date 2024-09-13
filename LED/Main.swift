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

@main
struct Main {
  static func main() {
    let led = try? Led(gpio: &led0)
    while true {
      if let led {
        led.toggle()
      }
      k_msleep(100)
    }
  }
}

struct Led {
  let gpio: UnsafePointer<gpio_dt_spec>

  init(gpio: UnsafePointer<gpio_dt_spec>) throws {
    if (!gpio_is_ready_dt(gpio)) {
      throw LedError.notReady
    }

    self.gpio = gpio

    // Note: & in Swift is not the "address of" operator, but on a global variable declared in C
    // it will give the correct address of the global.
    gpio_pin_configure_dt(gpio, GPIO_OUTPUT | GPIO_OUTPUT_INIT_HIGH | GPIO_OUTPUT_INIT_LOGICAL)
  }

  func toggle() {
     gpio_pin_toggle_dt(gpio)
  }
}

enum LedError: Error {
  case notReady
}