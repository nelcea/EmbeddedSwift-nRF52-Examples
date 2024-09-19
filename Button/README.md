# Button

This code started from the nrfx-blink-sdk example from Apple.  
Please look into the LED folder for more information and introduction on how to build.

To add interactivity, we'll now looked at using a button.  
We start by implementing everything in C, calling a single function from Swift.  
This ensures we have a working foundation, without having to tackle any of the issues Embedded Swift might throw at us.  
We now remove the C implementation and start the Swift implementation, one step at a time.  
Let's declare the reference to the GPIO pin and check the GPIO is ready.  