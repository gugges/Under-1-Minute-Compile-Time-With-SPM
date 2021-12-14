
import Foundation

/// The LogLevel
public enum LogLevel: Int {
    
    /// For debugging purposes
    case debug = 0

    /// To indicate app state.
    case info

    /// To indicate a problem
    case warning

    /// To indicate an error
    case error
}

/// Libraries can use this protocol to send logging information to the app
public protocol LogInterface {
    
    /// Used to send logging information to the app
    ///
    /// - Parameters:
    ///   - level: The log level
    ///   - message: The log message
    func log(level: LogLevel,
             message: @autoclosure () -> String,
             file: String,
             function: String,
             line: Int)
}

/// Helper extension
public extension LogInterface {
    
    /// Used to send logging information to the app
    /// Used for debugging purposes
    ///
    /// - Parameters:
    ///   - message: The log message
    func debug(_ message: @autoclosure () -> String,
               file: String = #file,
               function: String = #function,
               line: Int = #line) {
        log(level: .debug,
            message: message(),
            file: file,
            function: function,
            line: line)
    }

    /// Used to send logging information to the app
    /// Used to indicate app state. Similar to breadcrumbs.
    ///
    /// - Parameters:
    ///   - message: The log message
    func info(_ message: @autoclosure () -> String,
              file: String = #file,
              function: String = #function,
              line: Int = #line) {
        log(level: .info,
            message: message(),
            file: file,
            function: function,
            line: line)
    }

    /// Used to send logging information to the app
    /// Used to indicate a problem
    ///
    /// - Parameters:
    ///   - message: The log message
    func warning(_ message: @autoclosure () -> String,
                 file: String = #file,
                 function: String = #function,
                 line: Int = #line) {
        log(level: .warning,
            message: message(),
            file: file,
            function: function,
            line: line)
    }

    /// Used to send logging information to the app
    /// Used to indicate an error
    ///
    /// - Parameters:
    ///   - message: The log message
    func error(_ message: @autoclosure () -> String,
               file: String = #file,
               function: String = #function,
               line: Int = #line) {
        log(level: .error,
            message: message(),
            file: file,
            function: function,
            line: line)
    }
}
