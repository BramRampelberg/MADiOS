//
//  AppLogger.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 04/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import Foundation
import os

final class AppLogger {
    static private let logger = Logger()
    
    static private var timestamp: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: Date())
    }
    
    static func info(_ message: Any, file: String = #file, function: String = #function, line: Int = #line){
        log(level: .info, message: message, file: file, function: function, line: line)
    }
    
    static func error(_ message: Any, file: String = #file, function: String = #function, line: Int = #line){
        log(level: .error, message: message, file: file, function: function, line: line)
    }
    
    static func debug(_ message: Any, file: String = #file, function: String = #function, line: Int = #line){
        log(level: .debug, message: message, file: file, function: function, line: line)
    }
    
    static func warning(_ message: Any, file: String = #file, function: String = #function, line: Int = #line){
        log(level: .warning, message: message, file: file, function: function, line: line)
    }
    
    static private func log(level: Level, message: Any, file: String, function: String, line: Int){
        let fileName = (file as NSString).lastPathComponent

        let formattedMessage = "\(level) : [\(timestamp)] \(message) [\(fileName):\(line) \(function)]"
        
        switch level{
        case .info: logger.info("\(formattedMessage)")
        case .error: logger.error("\(formattedMessage)")
        case .debug: logger.debug("\(formattedMessage)")
        case .warning: logger.warning("\(formattedMessage)")
        }
    }
    
    private enum Level {
        case info
        case error
        case debug
        case warning
    }
    
    private init(){}
}
