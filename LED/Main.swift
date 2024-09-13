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
    let led = Led()
    while true {
      led.toggle()
      k_msleep(100)
    }
  }
}

struct Led {
  init() {
    // Note: & in Swift is not the "address of" operator, but on a global variable declared in C
    // it will give the correct address of the global.
    gpio_pin_configure_dt(&led0, GPIO_OUTPUT | GPIO_OUTPUT_INIT_HIGH | GPIO_OUTPUT_INIT_LOGICAL)
  }

  func toggle() {
     gpio_pin_toggle_dt(&led0)
  }
}