//
//  UIViewController+Extension.swift
//  Yummie
//
//  Created by Abdulrahman on 27/05/2022.
//

import UIKit

fileprivate var aView: UIView?

extension UIViewController {
    
    func showSpinner() {
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.25)
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = aView!.center
        activityIndicator.startAnimating()
        aView?.addSubview(activityIndicator)
        self.view.addSubview(aView!)
    }
    
    func hideSpinner() {
        aView?.removeFromSuperview()
        aView = nil
    }
    
    func showAlert(title: String = "", message: String = "", actions: [UIAlertAction] = []) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        
        if self.presentedViewController as? UIAlertController != nil {
            self.dismiss(animated: true, completion: nil)
        }
        
        present(alert, animated: true, completion: nil)
        
    }
}
