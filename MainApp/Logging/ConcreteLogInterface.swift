
import FirebaseAnalytics
import Interfaces

final class ConcreteLogInterface: LogInterface {
    
    func log(level: LogLevel,
             message: @autoclosure () -> String,
             file: String,
             function: String,
             line: Int) {
        let logEvent: String = "[\(level)] \(message())\n\(file)\n"
        print(logEvent)
        
        // Firebase Analytics
        Analytics.logEvent(logEvent, parameters: nil)
    }
}
