# Button

This code started from the nrfx-blink-sdk example from Apple.  
Please look into the LED folder for more information and introduction on how to build.

To add interactivity, we'll now looked at using a button.  
We start by implementing everything in C, calling a single function from Swift.  
This ensures we have a working foundation, without having to tackle any of the issues Embedded Swift might throw at us.  
We now remove the C implementation and start the Swift implementation, one step at a time.  
Let's declare the reference to the GPIO pin and check the GPIO is ready.  
If OK, configure the pin as input.  
Then configure the interrupt to be on transition to active state.  
Finally declare the handler as a closure, initialize the callback structure and add the callback on the button.  
Clean-up a bit by moving the code in a Button struct. This builds but does not work anymore.  