

import Foundation
import UIKit

extension UIView {
    func addBorder(edges: UIRectEdge, colour: UIColor = UIColor.white, thickness: CGFloat = 1, leftOffset: CGFloat = 0) {
        
        var borders = [UIView]()
        
        func border() -> UIView {
            let border = UIView(frame: CGRect.zero)
            border.backgroundColor = colour
            border.translatesAutoresizingMaskIntoConstraints = false
            return border
        }
        
        if edges.contains(.top) || edges.contains(.all) {
            let top = border()
            addSubview(top)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[top(==thickness)]",
                                                               options: [],
                                                               metrics: ["thickness": thickness],
                                                               views: ["top": top]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[top]-(0)-|",
                                                               options: [],
                                                               metrics: nil,
                                                               views: ["top": top]))
            borders.append(top)
        }
        
        if edges.contains(.left) || edges.contains(.all
            ) {
            let left = border()
            addSubview(left)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[left(==thickness)]",
                                                               options: [],
                                                               metrics: ["thickness": thickness],
                                                               views: ["left": left]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[left]-(0)-|",
                                                               options: [],
                                                               metrics: nil,
                                                               views: ["left": left]))
            borders.append(left)
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            let right = border()
            addSubview(right)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:[right(==thickness)]-(0)-|",
                                                               options: [],
                                                               metrics: ["thickness": thickness],
                                                               views: ["right": right]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[right]-(0)-|",
                                                               options: [],
                                                               metrics: nil,
                                                               views: ["right": right]))
            borders.append(right)
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            let bottom = border()
            addSubview(bottom)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:[bottom(==thickness)]-(0)-|",
                                                               options: [],
                                                               metrics: ["thickness": thickness],
                                                               views: ["bottom": bottom]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: String(format: "H:|-(%f)-[bottom]-(0)-|",leftOffset),
                                                               options: [],
                                                               metrics: nil,
                                                               views: ["bottom": bottom]))
            borders.append(bottom)
        }
    }

    class func instanceFromNib(nibName: String) -> UIView {
        return UINib(nibName: nibName, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }

    func startRotating(duration: Double = 1) {
        let kAnimationKey = "rotation"
        
        if self.layer.animation(forKey: kAnimationKey) == nil {
            let animate = CABasicAnimation(keyPath: "transform.rotation")
            animate.duration = duration
            animate.repeatCount = Float.infinity
            animate.fromValue = 0.0
            animate.toValue = Float(.pi * 2.0)
            self.layer.add(animate, forKey: kAnimationKey)
        }
    }
    func stopRotating() {
        let kAnimationKey = "rotation"
        
        if self.layer.animation(forKey: kAnimationKey) != nil {
            self.layer.removeAnimation(forKey: kAnimationKey)
        }
    }
    
    func instanceFromNib(nibName: String) -> UIView {
        return UINib(nibName: nibName, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
}





class SectionLineView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.addCustomView()
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.awakeFromNib()
//    }
    
    func addCustomView() {
        self.addBorder(edges: [.top,.bottom], colour: .gray, thickness: 1.0, leftOffset: 0) //SperatorBorderColor
    }
    

}
extension UIView {
    
    func takeScreenshot() -> UIImage {
        // Begin context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
    
    class func getActivityIndicatorViewForFooter() -> UIView {
        let constantFooterHeight : CGFloat = 50
        let footerView : UIView = UIView()
        footerView.frame.size = CGSize(width: UIScreen.main.bounds.size.width, height: constantFooterHeight)
        let _ : CGRect = CGRect(x: 0, y: 0, w: constantFooterHeight, h: constantFooterHeight)
        let actiVityView = UIActivityIndicatorView(style: .gray)
        actiVityView.color = UIColor.red
        footerView.addSubview(actiVityView)
        actiVityView.center = footerView.center
        actiVityView.anchorCenterSuperview()
        actiVityView.startAnimating()
        return footerView
    }
}


extension UIView {
    
    private struct AssociatedKeys {
        static var activityIndicator = "view.activityIndicator"
        static var orignalTitle = "view.orignalTitle"
        static var orignalImage = "view.orignalImage"
    }
    
    private var orignalTitle : String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.orignalTitle) as? String
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.orignalTitle, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    private var orignalImage : UIImage? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.orignalImage) as? UIImage
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.orignalImage, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    private var activitySpinner : UIActivityIndicatorView {
        get {
            if let indicator = objc_getAssociatedObject(self, &AssociatedKeys.activityIndicator) as? UIActivityIndicatorView {
                self.bringSubviewToFront(indicator)
                return indicator
            }else{
                
                let indicator = self.setupActivityIndicator()
                self.bringSubviewToFront(indicator)
                return indicator
            }
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.activityIndicator, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
  
    var isActivityIndicatorRunning : Bool  {
        
        return self.activitySpinner.isAnimating
        
    }
    
    func showSpinner(color:UIColor?) {
        var activityColor : UIColor = .black
        if let color = color {
            activityColor = color
        }
        DispatchQueue.main.async {
            if let button = self as? UIButton {
                self.orignalTitle = button.title(for: .normal)
                self.orignalImage = button.image(for: .normal)
                button.setImage(nil, for: .normal)
                button.setTitle(nil, for: .normal)
            }
            if let lable = self as? UILabel {
                self.orignalTitle = lable.text
                lable.text = ""
            }
            self.activitySpinner.color = activityColor
            self.activitySpinner.startAnimating()
        }
    }
    
    func hideSpinner() {
        DispatchQueue.main.async {
            self.activitySpinner.stopAnimating()
            let strTitle = self.orignalTitle
            if let button = self as? UIButton {
                button.setImage(self.orignalImage, for: .normal)
                button.setTitle(strTitle, for: .normal)
            }else if let lable = self as? UILabel {
                lable.text = strTitle
            }
        }
    }
    
    private func setupActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .red
        activityIndicator.isUserInteractionEnabled = false
        self.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)

        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
       
        activityIndicator.center = self.center
        
        self.activitySpinner = activityIndicator
        return activityIndicator
    }
    
}
