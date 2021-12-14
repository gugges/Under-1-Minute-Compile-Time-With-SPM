
import Interfaces

struct MockLogInterface: LogInterface {
    
    func log(level: LogLevel, message: @autoclosure () -> String, file: String, function: String, line: Int) {
        print("[\(level)] \(message())\n\(file)\n")
    }
    
}
