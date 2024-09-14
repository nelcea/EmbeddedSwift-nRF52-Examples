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
    do {
      let led = try Led(gpio: &led0)
      while true {
        do {
          try led.toggle()
        } catch {
          print("Could not toggle LED")
        }
        k_msleep(100)
      }
    } catch {
      print("Could not initialize LED")
    }
  }
}

struct Led {
  let gpio: UnsafePointer<gpio_dt_spec>

  init(gpio: UnsafePointer<gpio_dt_spec>) throws(LedError) {
    if (!gpio_is_ready_dt(gpio)) {
      throw .notReady
    }

    self.gpio = gpio

    // Note: & in Swift is not the "address of" operator, but on a global variable declared in C
    // it will give the correct address of the global.
    let ret = gpio_pin_configure_dt(gpio, GPIO_OUTPUT | GPIO_OUTPUT_INIT_HIGH | GPIO_OUTPUT_INIT_LOGICAL)
    switch ret {
      case 0:
        break
      case ENOTSUP:
        throw .invalidConfigurationOption
      case EINVAL:
        throw .invalidArgument
      case EIO:
        throw .ioError
      case EWOULDBLOCK:
        throw .wouldBlock
      default:
        throw .configureError(errorCode: ret)
    }
  }

  func on() throws (LedError) {
    let ret = gpio_pin_set_dt(gpio, 1)
    switch ret {
      case 0:
        break
      case EIO:
        throw .ioError
      case EWOULDBLOCK:
        throw .wouldBlock
      default:
        throw .configureError(errorCode: ret)
    }
  }

  func off() throws (LedError) {
    let ret = gpio_pin_set_dt(gpio, 0)
    switch ret {
      case 0:
        break
      case EIO:
        throw .ioError
      case EWOULDBLOCK:
        throw .wouldBlock
      default:
        throw .configureError(errorCode: ret)
    }
  }

  func toggle() throws (LedError) {
    let ret = gpio_pin_toggle_dt(gpio)
    switch ret {
      case 0:
        break
      case EIO:
        throw .ioError
      case EWOULDBLOCK:
        throw .wouldBlock
      default:
        throw .configureError(errorCode: ret)
    }
  }
}

enum LedError: Error {
  case notReady
  case invalidConfigurationOption
  case invalidArgument
  case ioError
  case wouldBlock
  case configureError(errorCode: Int32)
}