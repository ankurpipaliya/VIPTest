

import Foundation
import  UIKit

extension UIFont {
    
    class func families() {
        for family in UIFont.familyNames {
            print(family)
            for name in UIFont.fontNames(forFamilyName: family) {
                print(name)
            }
        }
    }
    
    class func font_Manrope_Semibold(size : CGFloat) -> UIFont {
        return UIFont(name: Resources.Fonts.Weight.Manrope_SemiBold.rawValue, size: size)!;
    }
    
    class func font_Manrope_Regular(size : CGFloat) -> UIFont {
        return UIFont(name: Resources.Fonts.Weight.Manrope_Regular.rawValue, size: size)!;
    }
    
    class func font_Manrope_Medium(size : CGFloat) -> UIFont {
        return UIFont(name: Resources.Fonts.Weight.Manrope_Medium.rawValue, size: size)!;
    }
    
    class func font_Manrope_BOLD(size : CGFloat) -> UIFont {
        return UIFont(name: Resources.Fonts.Weight.Manrope_Bold.rawValue, size: size)!;
    }
    
    class func font_OpensSans_Regular(size : CGFloat) -> UIFont {
        return UIFont(name: Resources.Fonts.Weight.Manrope_Regular.rawValue, size: size)!;
    }
    
    class func font_Manrope_Light(size : CGFloat) -> UIFont {
        return UIFont(name: Resources.Fonts.Weight.Manrope_Light.rawValue, size: size)!;
    }

}


struct Resources {

    struct Fonts {
        //struct is extended in Fonts
    }
}

extension Resources.Fonts {

    enum Weight: String {
        case Manrope_Bold = "Manrope-Bold"
        case Manrope_SemiBold = "Manrope-SemiBold"
        case Manrope_Medium = "Manrope-Medium"
        case Manrope_ExtraBold = "Manrope-ExtraBold"
        case Manrope_Light = "Manrope-Light"
        case Manrope_Regular = "Manrope-Regular"
        case Manrope_ExtraLight = "Manrope-ExtraLight"
    }
}

extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

extension UIFont {

   
    @objc convenience init(myCoder aDecoder: NSCoder) {
        guard
            let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
            let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
                self.init(myCoder: aDecoder)
                return
        }
        
        var fontName = ""
        switch fontAttribute {
        case "CTFontRegularUsage": // Regular
            fontName = Resources.Fonts.Weight.Manrope_Regular.rawValue
        case "CTFontMediumUsage": // Medium
            fontName = Resources.Fonts.Weight.Manrope_Medium.rawValue
        case "CTFontLightUsage": // Light
            fontName = Resources.Fonts.Weight.Manrope_Light.rawValue
        case "CTFontSemiboldUsage","CTFontDemiUsage": // SemiBold
//                        print("=======>>>>>>> ",fontAttribute)
            fontName = Resources.Fonts.Weight.Manrope_SemiBold.rawValue
        case "CTFontBoldUsage":
            fontName = Resources.Fonts.Weight.Manrope_Bold.rawValue // Bold
        case "CTFontEmphasizedUsage","CTFontHeavyUsage", "CTFontBlackUsage": // Bold
            fontName = Resources.Fonts.Weight.Manrope_Bold.rawValue
            
        default:
            fontName = fontAttribute
        }
        self.init(name: fontName, size: fontDescriptor.pointSize)!
    }

    class func overrideDefaultTypography() {
        guard self == UIFont.self else { return }

//        if let systemFontMethodWithWeight = class_getClassMethod(self, #selector(systemFont(ofSize: weight:))),
//            let mySystemFontMethodWithWeight = class_getClassMethod(self, #selector(mySystemFont(ofSize: weight:))) {
//            method_exchangeImplementations(systemFontMethodWithWeight, mySystemFontMethodWithWeight)
//        }
//
//        if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
//            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:))) {
//            method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
//        }
//
//        if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
//            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:))) {
//            method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
//        }
//
//        if let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:))),
//            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myItalicSystemFont(ofSize:))) {
//            method_exchangeImplementations(italicSystemFontMethod, myItalicSystemFontMethod)
//        }

        if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))),
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
            method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
        }
    }
}
