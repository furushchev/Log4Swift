//
//  PrintLogHandler.swift
//  Log4Swift
//
//  Created by FurutaYuki on 2016/12/26.
//
//

import Foundation

public class ConsoleLogHandler: FileLogHandler {
    public init(_ name: String, enabled: Bool = true, level: Logger.Level = .Info, colorize: Bool = false) {
        super.init(name, fileHandle: FileHandle.standardOutput, enabled: enabled, level: level, colorize: colorize)
    }
    deinit {}
}
