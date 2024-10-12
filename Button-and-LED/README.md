# Button

This code started from the nrfx-blink-sdk example from Apple.  
Please look into the LED folder for more information and introduction on how to build.

In this project, we combine the LED and Button projects and toggle the LED when pressing the button.  
We start by copying a simplified version (without error handling) of the Led struct from our LED project.  
We instantiate the struct to represent our physical LED and toggle it from the button closure.  
This fails to build as C function pointer can't be a closure that captures context.  
Making the led constant global is one way to solve the issue.  
Another way is to make it a static property on the Led struct.  

Check out the [Creating a Swift type for button input on nRF52 - Part 2](https://www.ericbariaux.com/posts/button_embedded_swift_nrf52_part2/) blog post to follow along as we build this sample code.
