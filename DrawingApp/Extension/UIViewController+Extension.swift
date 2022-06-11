//
//  UIViewController+Extension.swift
//  DrawingApp
//
//  Created by Abdulrahman on 09/06/2022.
//

import UIKit

extension UIViewController {
        
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
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
