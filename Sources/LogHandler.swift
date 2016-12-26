//
//  LogHandler.swift
//  Log4Swift
//
//  Created by FurutaYuki on 2016/12/26.
//
//

import Foundation

public protocol LogHandler {
    var level: Logger.Level { get set }
    var name: String { get set }
    var enabled: Bool { get set }
    
    func write(_ level: Logger.Level, _ message: String, function: String, file: String, line: Int)
}
