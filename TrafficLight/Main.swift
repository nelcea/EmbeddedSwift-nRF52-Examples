@main
struct Main {
  static func main() {
  
    let trafficLight = TrafficLight()

    let btn1 = Button<TrafficLight>(gpio: &button, context: trafficLight) { _, callback, _ in
      ExtendedCallback<TrafficLight>.containerFrom(callback: callback!).context.push()
    }

    let mainLoop = MainLoop()
    mainLoop.run()
  }
}

class TrafficLight {
  let redLed = Led(gpio: &redled)
  let yellowLed = Led(gpio: &yellowled)
  let greenLed = Led(gpio: &greenled)

  var timer: Timer<TrafficLight>?

  var state: TrafficLightState {
    didSet {
      // Based on state, configure the LEDs appropriately
      switch state {
      case .green:
        redLed.off()
        yellowLed.off()
        greenLed.on()
      case .yellow:
        greenLed.off()
        redLed.off()
        yellowLed.on()
      case .red:        
        yellowLed.off()
        greenLed.off()
        redLed.on()
      }
    }
  }
  
  init() {
    state = .green

    // didSet is not triggered, manually configure the LEDs
    // see https://forums.swift.org/t/didset-is-not-triggered-while-called-after-super-init/45226/10
    redLed.off()
    yellowLed.off()
    greenLed.on()
  }

  func push() {
    guard state == .green else { return }
    state = .yellow
    timer = Timer<TrafficLight>(userData: self, delay: 3000) { timer in
      Timer<TrafficLight>.getUserData(timer).toRed()
    }
  }

  private func toRed() {
    guard state == .yellow else { return }
    state = .red
    timer = Timer<TrafficLight>(userData: self, delay: 20_000) { timer in
      Timer<TrafficLight>.getUserData(timer).toGreen()
    }
  }

  private func toGreen() {
    guard state == .red else { return }
    state = .green
  }
}