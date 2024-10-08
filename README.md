# Examples of Embedded Swift code for nRF52xxx micro-controllers

This repository contains examples of Embedded Swift code exercising the different features of development boards based on nRF52xxx microcontrollers.

## LED

The LED folder contains a Swift struct that abstracts away all the C calls to Zephyr and presents a natural interface to control an LED connected to a GPIO pin.  
It is initially based on the [nrfx-blink-sdk](https://github.com/apple/swift-embedded-examples/tree/main/nrfx-blink-sdk) example provided by Apple.

Check out the [Controlling a LED using Embedded Swift on nRF52](https://www.ericbariaux.com/posts/led_embedded_swift_nrf52/) blog post to follow along as we build from this sample code.

## Button

To add interactivity, we'll now looked at using a button.  
Look at the README.md file inside the Button folder for more information.  