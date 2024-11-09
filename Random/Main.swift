@main
struct Main {
  static func main() {
    while true {
      let randomDigit = Int.random(in: 0...9)
      print("Digit: \(randomDigit)")
      k_msleep(5000)
    }
  }
}