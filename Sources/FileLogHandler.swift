//
//  FileLogHandler.swift
//  Log4Swift
//
//  Created by FurutaYuki on 2016/12/26.
//
//

import Foundation

extension String {
    private var nsstring: NSString {
        return (self as NSString)
    }
    public var lastPathComponent: String {
        return nsstring.lastPathComponent
    }
}

public class FileLogHandler: LogHandler {
    public var level: Logger.Level
    public var name: String
    public var enabled: Bool
    public var colorize: Bool
    
    let fileHandle: FileHandle
    
    public enum Error: Swift.Error {
        case FileCreateError(String)
        case FileOpenError(String)
        case FileWriteError(String)
    }
    
    private func formatDate(_ date: Date) -> String {
        let date = Date()
        let secs = UInt64(date.timeIntervalSince1970)
        let nsecs = Calendar.current.component(.nanosecond, from: date)
        return "\(secs).\(nsecs)"
    }
    
    private func colorizeString(level: Logger.Level, message: String) -> String {
        switch level {
        case .Debug:
            return message.ForeGreen
        case .Info:
            return message
        case .Warn:
            return message.ForeLightYellow.StyleBold
        case .Error:
            return message.ForeLightRed.StyleBold
        case .Fatal:
            return message.ForeRed.StyleBold
        }
    }
    
    public func write(_ level: Logger.Level, _ message: String, function: String, file: String, line: Int) {
        let date = Date()
        let format = "[\(level)] [\(self.formatDate(date))] [\(file.lastPathComponent):\(line):\(function)] \(message)\n"
        var data: Data?
        if self.colorize {
            data = colorizeString(level: level, message: format).data(using: String.Encoding.utf8)
        } else {
            data = format.data(using: String.Encoding.utf8)
        }
        if let data_ = data {
            self.fileHandle.write(data_)
        }
    }
    
    public init(_ name: String, fileHandle: FileHandle, enabled: Bool = true, level: Logger.Level = .Info, colorize: Bool = false) {
        self.name = name
        self.fileHandle = fileHandle
        self.enabled = enabled
        self.level = level
        self.colorize = colorize
    }
    
    public convenience init(_ name: String, outputPath: String, enabled: Bool = true, level: Logger.Level = .Info, colorize: Bool = false) throws {
        let manager = FileManager.default
        if !manager.fileExists(atPath: outputPath) {
            if !manager.createFile(atPath: outputPath, contents: nil, attributes: nil) {
                throw Error.FileCreateError(outputPath)
            }
        }
        guard let handle = FileHandle(forWritingAtPath: outputPath) else {
            throw Error.FileOpenError(outputPath)
        }
        self.init(name, fileHandle: handle, enabled: enabled, level: level, colorize: colorize)
    }
    
    deinit {
        self.fileHandle.closeFile()
    }
}
