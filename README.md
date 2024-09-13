# Examples of Embedded Swift code for nRF52xxx micro-controllers

This repository contains examples of Embedded Swift code exercising the different features of development boards based on nRF52xxx microcontrollers.

It starts from the [nrfx-blink-sdk](https://github.com/apple/swift-embedded-examples/tree/main/nrfx-blink-sdk) example provided by Apple.  
But the code in the sample is not very "Swifty", so we start by isolating the code related to controlling the LED GPIO in a struct. The main function now reads more like standard Swift.  
The GPIO pin was hardcoded, we now pass it as a parameter to the struct initializer.  
If you look more closely at the nRF Connect SDK documentation, it indicates that we should first check if the GPIO is ready before configuring a pin. Let's add this check to our initializer, making it throwing.  
Our first tries fails to build, as *throws* is equivalent to _throws any Error_, and Embedded Swift does not support existentials.  
We fix that by using Typed throws, introduced in Swift 6.  
We ignored the error so far, let's catch it and print an error message to the console.  
Again, the build fails, but this time the error is more mysterious.  
A commit from Apple on their examples fixed the issue (the -fno-pic flag is the important change).  

Check out the [Controlling a LED using Embedded Swift on nRF52](https://www.ericbariaux.com/posts/led_embedded_swift_nrf52/) blog post to follow along as we build from this sample code.