//
//  Logger.swift
//  SwiftSocial
//
//  Created by Phyo Myanmar Kyaw on 10/27/25.
//

import Foundation

enum Log {
    enum LogLevel {
        case info, warning, error
    }
    
    static func message(_ msg: Any, level: LogLevel = .info, file: String = #file, function: String = #function, line: Int = #line) {
#if DEBUG
        let fileName = (file as NSString).lastPathComponent
        var icon = "ℹ️"
        switch level {
        case .info: icon = "ℹ️"
        case .warning: icon = "⚠️"
        case .error: icon = "❌"
        }
        print("\(icon) [\(fileName):\(line)] \(function) -> \(msg)")
#endif
    }
}
