# Examples of Embedded Swift code for nRF52xxx micro-controllers

This repository contains examples of Embedded Swift code exercising the different features of development boards based on nRF52xxx microcontrollers.

## LED

The LED folder contains a Swift struct that abstracts away all the C calls to Zephyr and presents a natural interface to control an LED connected to a GPIO pin.  
It is initially based on the [nrfx-blink-sdk](https://github.com/apple/swift-embedded-examples/tree/main/nrfx-blink-sdk) example provided by Apple.

Check out the [Controlling a LED using Embedded Swift on nRF52](https://www.ericbariaux.com/posts/led_embedded_swift_nrf52/) blog post to follow along as we build from this sample code.

## Button

To add interactivity, we'll now look at using a button.  
Look at the README.md file inside the Button folder for more information.  

## Button and LED

We build on the previous 2 projects and create a button that toggles the LED on and off when pressed.  
Check out the [Creating a Swift type for button input on nRF52 - Part 1](https://www.ericbariaux.com/posts/button_embedded_swift_nrf52/) and [Creating a Swift type for button input on nRF52 - Part 2](https://www.ericbariaux.com/posts/button_embedded_swift_nrf52_part2/) blog posts for more information.

## Random

In this project, we show how to generate random numbers using Embedded Swift and nRF Connect SDK.  
Check out the [Randomness on nRF52 using Embedded Swift](https://www.ericbariaux.com/posts/random_nrf52/) blog post for more information.

## Traffic Light

This example implements a simple traffic light, with some basic timing logic to move between the different states.  