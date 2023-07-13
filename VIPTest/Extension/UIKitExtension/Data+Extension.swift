//
//  Data+Extension.swift
//  BaseCode
//
//  Created by Apple on 22/01/21.
//

import Foundation
import UIKit


extension Data {
    var json : [String:Any]  {
        get {
            let dictData = try? JSONSerialization.jsonObject(with: self, options: []) as? [String:Any]
            if let dict = dictData {
                return dict
            }
            return [:]
        }
        
    }
    
    var jsonDictionary : [String:Any]?  {
        get {
            let dictData = try? JSONSerialization.jsonObject(with: self, options: []) as? [String:Any]
            if let dict = dictData {
                return dict
            }
            return nil
        }
        
    }
    
    var stringValue : String {
        get {
            
            let jsonString = String(decoding: self, as: UTF8.self)
            return jsonString
            
        }
    }
    
    
}

extension Dictionary {
    
    var json : String {
        get {
            let jsonData = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            
            if let jsonData = jsonData {
                let jsonString = String(decoding: jsonData, as: UTF8.self)
                return jsonString
            }
            return ""
        }
    }
    
    var data : Data? {
        get {
            let jsonData = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            if let jsonData = jsonData {
                return jsonData
            }
            return nil
        }
    }
}

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}

extension Array {
    
    var json : String {
        get{
            guard let data = try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted]) else {
                return ""
            }
            return String(data: data, encoding: String.Encoding.utf8) ?? ""
        }
    }
}
