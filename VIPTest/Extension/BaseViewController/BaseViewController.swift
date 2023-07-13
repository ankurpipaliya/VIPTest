//
//  BaseVC.swift
//  TesConfirm
//
//  Created by SOTSYS044 on 13/08/19.
//  Copyright © 2019 SOTSYS203. All rights reserved.
//

import UIKit
import SystemConfiguration


/*---------------------------------------------------
 Ratio
 ---------------------------------------------------*/
// MARK:- Ratio
let _screenSize = UIScreen.main.bounds.size
let _heightRatio : CGFloat = {
    let ratio = _screenSize.height / 812
    return ratio
}()

let _widthRatio : CGFloat = {
    let ratio = _screenSize.width / 375
    return ratio
}()

// MARK:- CollectionView Cells
class ConstrainedColCell: UICollectionViewCell {
    
    //MARK: IBOutlets
    @IBOutlet var horizontalConstraints: [NSLayoutConstraint]?
    @IBOutlet var verticalConstraints: [NSLayoutConstraint]?
    
    //MARK: AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        constraintUpdate()
    }
    
    
    // This will update constaints and shrunk it as device screen goes lower.
    //MARK: Update Constraint
    func constraintUpdate() {
        if let hConts = horizontalConstraints {
            for const in hConts {
                let v1 = const.constant
                let v2 = v1 * _widthRatio
                const.constant = v2
            }
        }
        if let vConst = verticalConstraints {
            for const in vConst {
                let v1 = const.constant
                let v2 = v1 * _heightRatio
                const.constant = v2
            }
        }
    }
    
}

// MARK:- TableVeiwCells
class ConstrainedTblCell: UITableViewCell {
    
    //MARK: IBOutlets
    @IBOutlet var horizontalConstraints: [NSLayoutConstraint]?
    @IBOutlet var verticalConstraints: [NSLayoutConstraint]?
    
    // MARK:- AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        constraintUpdate()
    }
    
    
    // This will update constaints and shrunk it as device screen goes lower.
    // MARK:- Constraint Update
    func constraintUpdate() {
        if let hConts = horizontalConstraints {
            for const in hConts {
                let v1 = const.constant
                let v2 = v1 * _widthRatio
                const.constant = v2
            }
        }
        if let vConst = verticalConstraints {
            for const in vConst {
                let v1 = const.constant
                let v2 = v1 * _heightRatio
                const.constant = v2
            }
        }
    }
    
}
/// This Class will decrease font size as well it will make intrinsiz content size 10 pixel bigger as it need padding on both side of label

// MARK:- VDPointsLabel
class VDPointsLabel: UILabel {
    
    // MARK:- AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        font = font.withSize(font.pointSize * _widthRatio)
        self.layer.masksToBounds = true
    }
    
    // MARK:- ContentSize
    override var intrinsicContentSize: CGSize{
        let asize = super.intrinsicContentSize
        if self.text?.count == 1{
            return CGSize(width: (22 * _widthRatio) , height: asize.height + (4 * _widthRatio))
        }else{
            let width = asize.width + (2 * _widthRatio)
            let height = asize.height + (4 * _widthRatio)
            return CGSize(width: (width < height ? height : width) , height: height)
        }
    }
}



// MARK:- BaseViewController
class BaseViewController: UIViewController {

    // MARK:- Variables
    private let activityIndicatorView = UIActivityIndicatorView(style: .gray)
    //var networkManager: NetworkReachabilityManager = NetworkReachabilityManager()!
    @IBOutlet var horizontalConstraints: [NSLayoutConstraint]?
    @IBOutlet var verticalConstraints: [NSLayoutConstraint]?
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicatorView()
        constraintUpdate()
        
    }
    
    // This will update constaints and shrunk it as device screen goes lower.
    // MARK:- Constraint Update
    func constraintUpdate() {
        if let hConts = horizontalConstraints {
            for const in hConts {
                let v1 = const.constant
                let v2 = v1 * _widthRatio
                const.constant = v2
            }
        }
        if let vConst = verticalConstraints {
            for const in vConst {
                let v1 = const.constant
                let v2 = v1 * _heightRatio
                const.constant = v2
            }
        }
        
        self.updateLayout()
    }
    
    // MARK:- Update Layout
    func updateLayout() {
        self.view.updateConstraints()
        self.view.layoutIfNeeded()
        self.view.setNeedsLayout()
    }
    
    
    
    // MARK:- Navigation Methods
    func setLeftBarButton(img: UIImage?) {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: img?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarBtnAction))
    }
    
    func hidenavigationBar(){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func showNavigationBar(){
        self.navigationController!.setNavigationBarHidden(false, animated: true)
    }
    
    func hideLeftBarBtn() {
        self.navigationItem.leftBarButtonItem = nil
    }
    
    func hideLeftSideButtonBack(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
    func hiderightSideButtonBack(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
    
    @objc func leftBarBtnAction() {
        
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    @objc func RightBarBtnAction() {
        
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    func setTitleNavigationController(text: String,fontname:String,fontSize:CGFloat,colourName:UIColor){
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: colourName,
             NSAttributedString.Key.font: UIFont.init(name: fontname, size: fontSize)!]
        self.navigationItem.title = text
    }
    
  
    // MARK:- Read Property List
    private func readPropertyList(plistName:String) -> Array<Any>?{
        var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml //Format of the Property List.
        var plistData:Array<Any>? //Our data
        let plistPath: String? = Bundle.main.path(forResource: plistName, ofType: "plist")! //the path of the data
        let plistXML = FileManager.default.contents(atPath: plistPath!)!
        do {//convert the data to a dictionary and handle errors.
            plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as? Array
            
            return plistData
        } catch {
            print("Error reading plist: \(error), format: \(propertyListFormat)")
            return []
        }
    }
    
    
    // Set up status bar (battery, time, etc.) to white
    // MARK:- Preferred StatusBar
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
    

    // MARK:- Show-Hide Spinner
    func showSpinner(_ isUserInterectionEnable:Bool = true) {
        DispatchQueue.main.async {
            self.activityIndicatorView.isHidden = false
            self.view.isUserInteractionEnabled = isUserInterectionEnable
            self.view.bringSubviewToFront(self.activityIndicatorView)
            self.activityIndicatorView.startAnimating()
            return
            /*
            self.indicator.isHidden = false
            self.view.isUserInteractionEnabled = isUserInterectionEnable
            self.indicator.startAnimating()
             */
        }
    }
    
    func hideSpinner() {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorView.isHidden = true
            self.view.isUserInteractionEnabled = true
            return
            /*
            self.indicator.isHidden = true
            self.view.isUserInteractionEnabled = true
            self.indicator.stopAnimating()
            */
        }
    }
    
    // MARK:- Check Internet Connection
    func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == false {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
        /*
        if true { //networkManager.isReachable{
            return true
        }else{
            return false
        }
        */
    }
    
    // MARK:- Setup Activity Indicator
    private func setupActivityIndicatorView() {
        if #available(iOS 13, *) {
            self.activityIndicatorView.style = .large
        }else{
            self.activityIndicatorView.style = .whiteLarge
        }
        self.activityIndicatorView.style = .gray
        self.activityIndicatorView.isHidden = true
        self.activityIndicatorView.hidesWhenStopped = true
        self.activityIndicatorView.color = UIColor.black
        self.view.addSubview(self.activityIndicatorView)
        activityIndicatorView.center = self.view.center
        self.activityIndicatorView.anchorCenterSuperview()
    }
    
    
    // MARK:- Copy Text In PasteBoard
    func copyTextInPasteBoardFromString(string:String) {
        UIPasteboard.general.string = string
    }
    
    // MARK:- Share Text - Array Using Default Share Kit
    func shareTextInDefaultShareKit(string:String) {
        let activityVC = UIActivityViewController(activityItems: [string], applicationActivities: nil)
        self.presentVC(activityVC)
    }
    
    
    func shareTextInDefaultShareKit(array:[Any]) {
        let activityVC = UIActivityViewController(activityItems: array, applicationActivities: nil)
        self.presentVC(activityVC)
    }
    
    // use it dropdown pod if needed and this method to setup
    // MARK:- DropDownMethod
    /*
    func showDropDown(dropDown:DropDown,anchorView:UIView,arr:[String],direction:DropDown.Direction = .any,containerView:UIView? = nil,complation: @escaping ((Int,String)->())) {
        
        dropDown.anchorView = anchorView
        dropDown.bottomOffset = CGPoint(x: 0, y: anchorView.bounds.height)
        dropDown.dataSource = arr
        dropDown.direction = direction
        dropDown.backgroundColor = .Picture_BG_Light_Colour
        dropDown.shadowColor1 = UIColor.black.withAlphaComponent(0.25)
        dropDown.selectionAction = { (index, item) in
            complation(index,item)
        }
        dropDown.show(onTopOf: containerView == nil ? self.view : containerView, beforeTransform: nil, anchorPoint: nil)
        
    }
    */

    // MARK:- CallToPhoneNumber
    func callToPhoneNumber(string:String) {
        let strContactNumber : String = string.replacingOccurrences(of: "tel://", with: "")
        if let url = URL(string: "tel://\(strContactNumber)"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}

