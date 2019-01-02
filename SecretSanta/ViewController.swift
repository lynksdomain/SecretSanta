//
//  ViewController.swift
//  SecretSanta
//
//  Created by C4Q on 12/30/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase
import GhostTypewriter

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var consoleView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var logInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        FirebaseBrain.manager.delegate = self
        setUp()
    }
    
    
    private func setUp() {
        Scanline.addScanline(to: consoleView)
        titleLabel.glow()
        titleLabel.Blink()
        emailLabel.glow()
        passwordLabel.glow()
        passwordTextField.glow()
        emailTextField.glow()
        passwordTextField.addBorder()
        emailTextField.addBorder()
        logInButton.glow()
        logInButton.addBorder()
    }
    
    
    
    
    
  
    
    
    
    @IBAction func screenTapped(_ sender: UITapGestureRecognizer) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    
    
    
    @IBAction func signInPressed(_ sender: UIButton) {
    guard let email = emailTextField.text,
        let password = passwordTextField.text else { return }
     FirebaseBrain.manager.logIn(email: email, password: password)
    }
    
    
}


extension ViewController: FirebaseBrainDelegate {
    func didSignIn() {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MessageVC")
        present(vc, animated: true, completion: nil)
    }
    func failToSignIn(error: Error) { self.showAlert(message: error.localizedDescription)}
}



extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
}
