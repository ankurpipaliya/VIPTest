//
//  Constant.swift
//  BaseCode
//
//  Created by Apple on 21/12/20.
//

import Foundation
import UIKit

class Constant : NSObject {
    
    #if DEBUG
    
    public static var BASE_URL = ""
    
    #else // Release
    
    public static var BASE_URL = ""
    
    #endif
    
}

