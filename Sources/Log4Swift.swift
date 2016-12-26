//
//  Log4Swift.swift
//  Log4Swift
//
//  Created by FurutaYuki on 2016/12/26.
//
//

import Foundation

public class Logger {
    public enum Level: Int, Comparable, CustomStringConvertible {
        case Debug = 1
        case Info
        case Warn
        case Error
        case Fatal
        
        public static func <(lhs: Level, rhs: Level) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }
        
        public var description: String {
            switch self {
            case .Debug: return "DEBUG"
            case .Info : return " INFO"
            case .Warn : return " WARN"
            case .Error: return "ERROR"
            case .Fatal: return "FATAL"
            }
        }
    }

// MARK: - Handlers
    
    private var handlers = [LogHandler]()

    public func registerHandler(_ handler: LogHandler) {
        if self.handlers.first(where: { $0.name == handler.name }) == nil {
            self.handlers.append(handler)
        }
    }
    public func unregisterHandler(_ handler: LogHandler) {
        self.unregisterHandler(handler.name)
    }
    public func unregisterHandler(_ name: String) {
        if let index = self.handlers.index(where: { $0.name == name }) {
            self.handlers.remove(at: index)
        }
    }
    
    public subscript(name: String) -> LogHandler? {
        return self.handlers.first { $0.name == name }
    }

// MARK: - Logging
    
    private func write(_ level: Level, _ message: @autoclosure () -> String?, function: String, file: String, line: Int) {
        self.handlers.filter({ $0.enabled && $0.level <= level }).forEach { handler in
            if let msg = message() {
                handler.write(level, msg, function: function, file: file, line: line)
            }else {
                handler.write(level, "nil", function: function, file: file, line: line)
            }
        }
    }
    
    public func debug(_ message: @autoclosure () -> String?, function: String = #function, file: String = #file, line: Int = #line) {
        write(.Debug, message, function: function, file: file, line: line)
    }
    
    public func info(_ message: @autoclosure () -> String?, function: String = #function, file: String = #file, line: Int = #line) {
        write(.Info, message, function: function, file: file, line: line)
    }
    
    public func warn(_ message: @autoclosure () -> String?, function: String = #function, file: String = #file, line: Int = #line) {
        write(.Warn, message, function: function, file: file, line: line)
    }

    public func error(_ message: @autoclosure () -> String?, function: String = #function, file: String = #file, line: Int = #line) {
        write(.Error, message, function: function, file: file, line: line)
    }

    public func fatal(_ message: @autoclosure () -> String?, function: String = #function, file: String = #file, line: Int = #line) {
        write(.Fatal, message, function: function, file: file, line: line)
    }
    
// MARK - Initializer
    private struct Static {
        static let instance: Logger = Logger()
    }
    public class func logger() -> Logger {
        return Static.instance
    }
    private init() {}
}
