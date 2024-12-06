# Random

This project shows how to implement a Timer in Embedded Swift using the nRF Connect SDK.  
It allows us to easily schedule a closure for later execution and optional repetition.  

The memory leak is fixed by doing the clean-up in deinit.  
But now our example code does not work anymore.  
Keeping hold of the created timers fixes the issue.  

Check out the [Timers in Swift on nRF52](https://www.ericbariaux.com/posts/timer_swift_nrf52/) blog post for explanations on the code present in this project.