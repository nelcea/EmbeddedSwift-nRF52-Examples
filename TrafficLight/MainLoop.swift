struct MainLoop {
  func run() {
    print("Main loop starting")
    while true {
      // Nothing to do really in main loop
      k_msleep(500)
    }
  }
}
