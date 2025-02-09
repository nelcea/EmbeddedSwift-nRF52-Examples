# TrafficLight

This example demonstrates a simple TrafficLight logic, using green, yellow, red LEDs and a button.  
When pressing the button on green, the light will switch to yellow for a little while, then to red and finally after a longer delay back to green.  
It has been built for the nRF52840dk board using the nRF Connect SDK.  
The button used is the "BUTTON 1" on the board but LEDs are external, connected to the header pins for P1.10 (green), P1.11 (yellow) and P1.12 (red).  

Update Feb-2025: Also check out [Addressing Previous Oversights](https://www.ericbariaux.com/posts/previous_oversights_nrf52/) as it explains some issues with the initial sample code.