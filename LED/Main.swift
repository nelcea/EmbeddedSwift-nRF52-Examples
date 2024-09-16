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