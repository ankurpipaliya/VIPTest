//
//  CustomizedFucntions.swift
//  BaseCode
//
//  Created by Apple on 22/01/21.
//

import Foundation
import UIKit

enum UserDefaultInfoKey : String {
    case user
}


func Localized_Custom(string:String) -> String {
    return NSLocalizedString(string, tableName: nil, bundle:  Bundle(path: Bundle.main.path(forResource: "en" , ofType: "lproj")!)!, value: "", comment: "")
}


public func TLogCustom(_ items: Any..., separator: String = " ", terminator: String = "\n",file: String = #file, function: String = #function, line: Int = #line) {
    #if DEBUG
    let output = items.map { "\($0)"}.joined(separator: " ")
    Swift.print("======== Start ========")
    Swift.print("\((file as NSString).lastPathComponent)")
    Swift.print("Function : \(function) Line : \(line)")
    Swift.print(output, terminator: terminator)
    Swift.print("======== End ========")
    #endif
}


func setDataInString(_ str:AnyObject) -> String {
    var strConverted : String = ""
    
    if let strTemp = str as? Int {
        strConverted = String(strTemp)
    }else if let strTemp = str as? Int64 {
        strConverted = String(strTemp)
    }else if let strTemp = str as? Double {
        strConverted = String(strTemp)
    }else if let strTemp = str as? Float {
        strConverted = String(strTemp)
    }else if let strTemp = str as? CGFloat {
        strConverted = String(Float(strTemp))
    }else if let strTemp = str as? NSNumber {
        strConverted = strTemp.stringValue
    }else if let strTemp = str as? String {
        strConverted = strTemp
    }
    
    return strConverted
}

