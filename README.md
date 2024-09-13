# Examples of Embedded Swift code for nRF52xxx micro-controllers

This repository contains examples of Embedded Swift code exercising the different features of development boards based on nRF52xxx microcontrollers.

It starts from the [nrfx-blink-sdk](https://github.com/apple/swift-embedded-examples/tree/main/nrfx-blink-sdk) example provided by Apple.  
But the code in the sample is not very "Swifty", so we start by isolating the code related to controlling the LED GPIO in a struct. The main function now reads more like standard Swift.


Check out the [Controlling a LED using Embedded Swift on nRF52](https://www.ericbariaux.com/posts/led_embedded_swift_nrf52/) blog post to follow along as we build from this sample code.