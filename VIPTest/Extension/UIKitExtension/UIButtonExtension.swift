

import Foundation
import UIKit

extension UIButton {
    
    func setImagesTintColor(color:UIColor,arrState:[UIControl.State]) {
        for state in arrState {
            if let image = self.image(for: state) {
                let newImage = image.withRenderingMode(.alwaysTemplate)
                self.setImage(newImage, for: state)
            }
        }
        self.tintColor = color
    }
    
    func setTitleForAllState(string:String) {
        let arr : [UIControl.State] = [.normal,.selected,.highlighted,.disabled]
        for state in arr {
            self.setTitle(string, for: state)
        }
    }
    
}


