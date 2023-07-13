//
//  AlertUIViewController+Extension.swift
//  BaseCode
//
//  Created by Apple on 22/01/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    
    @discardableResult public func showAlert(title: String?, message: String?, buttonTitles: [String]? = nil, highlightedButtonIndex: Int? = nil, completion: ((Int) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var allButtons = buttonTitles ?? [String]()
        if allButtons.count == 0 {
            allButtons.append("OK")
        }
        
        for index in 0..<allButtons.count {
            let buttonTitle = allButtons[index]
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { (_) in
                completion?(index)
            })
            alertController.addAction(action)
            // Check which button to highlight
            if let highlightedButtonIndex = highlightedButtonIndex, index == highlightedButtonIndex {
                if #available(iOS 9.0, *) {
                    alertController.preferredAction = action
                }
            }
        }
        present(alertController, animated: true, completion: nil)
        return alertController
    }
    
    
    @discardableResult public func showAlertSheet(title: String?, message: String?,attributedTitle:NSMutableAttributedString?,attributedMessage:NSMutableAttributedString?, buttonTitles: [String]? = nil, highlightedButtonIndex: Int? = nil, completion: ((Int) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        var allButtons = buttonTitles ?? [String]()
        if allButtons.count == 0 {
            allButtons.append("OK")
        }
        
        if let attributedTitle = attributedTitle {
            alertController.setTitletAttributed(string: attributedTitle)
        }
        
        if let attributedMessage = attributedMessage {
            alertController.setMessageAttributedString(string: attributedMessage)
        }
        
        for index in 0..<allButtons.count {
            let buttonTitle = allButtons[index]
            let action : UIAlertAction?
            if buttonTitle == "Cancel" {
                action = UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
                    completion?(index)
                })
            }else{
                action = UIAlertAction(title: buttonTitle, style: .default, handler: { (_) in
                    completion?(index)
                })
                action?.setValue(UIColor.black, forKey: "titleTextColor")
            }
            if let action = action {
                alertController.addAction(action)
            }
            if let highlightedButtonIndex = highlightedButtonIndex, index == highlightedButtonIndex {
                alertController.preferredAction = action
                
            }
            
            // Check which button to highlight
            
        }
        
        present(alertController, animated: true, completion: nil)
        return alertController
    }
    
    func showNoNetworkAlert(strBtnTitle:String = "",complationNoNetwork:(()->())? = nil) {
        
        let alertController = UIAlertController(title: "", message: "No internet connection available", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: { (_) in
            alertController.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func showAlertWithOkAndCancelHandler(string: String,strOk:String,strCancel : String,handler: @escaping (_ isOkBtnPressed : Bool)->Void)
    {
       
        let alert = UIAlertController(title: "", message: string, preferredStyle: .alert)
        
        let alertOkayAction = UIAlertAction(title: strOk, style: .default) { (alert) in
            handler(true)
        }
        let alertCancelAction = UIAlertAction(title: strCancel, style: .default) { (alert) in
            handler(false)
        }
        alert.addAction(alertCancelAction)
        alert.addAction(alertOkayAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func showAlert(string:String,handler: (()->())? = nil) {
        let alert = UIAlertController(title: "", message: string, preferredStyle: .alert)
        let alertOkayAction = UIAlertAction(title: "Okay", style: .default) { (_) in
            handler?()
        }
        alert.addAction(alertOkayAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
}
