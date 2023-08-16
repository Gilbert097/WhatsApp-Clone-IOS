//
//  LogUtils.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 16/08/23.
//

import Foundation

final class LogUtils {
    
    static var shared: LogUtils = {
        LogUtils()
      }()
    
    private init(){}
    
    static func printMessage(tag: String, message: String){
        let formate = Date().getFormattedDate(format: "yyyy-MM-dd HH:mm:ss.SSS")
        print("\(formate) \(tag): \(message)")
    }
    
}

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
