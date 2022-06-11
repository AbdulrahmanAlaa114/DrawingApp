//
//  UIView+Extension.swift
//  DrawingApp
//
//  Created by Abdulrahman on 09/06/2022.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { self.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
    
    func takeScreenshot() -> UIImage {

        // Begin context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)

        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)

        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if (image != nil) { return image! }
        
        return UIImage()
    }
}
