//
//  Extension.swift
//  
//
//  Created by C4Q on 12/31/18.
//

import UIKit

extension UIView {
    func glow() {
        self.layer.shadowColor = UIColor.green.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 10
    }
    
    func Blink(){
        self.alpha = 0.3
        UIView.animate(withDuration: 2, delay: 0, options:[.repeat,.autoreverse],
                       animations:{ self.alpha=1.0 }, completion: nil)
    }
    
    
    func addBorder() {
        self.layer.borderColor = UIColor.green.cgColor
        self.layer.borderWidth = 1
    }
}


extension UIViewController {
     func showAlert(message: String) {
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
