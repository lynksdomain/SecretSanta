//
//  MessageViewController.swift
//  SecretSanta
//
//  Created by C4Q on 12/31/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import GhostTypewriter
class MessageViewController: UIViewController {
 
    @IBOutlet weak var messageLabel: TypewriterLabel!
    @IBOutlet weak var consoleView: UIView!
    
    @IBOutlet weak var signOutButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseBrain.manager.getMessage()
        FirebaseBrain.manager.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        messageLabel.glow()
        signOutButton.glow()
        Scanline.addScanline(to: self.consoleView)
    }
    
    @IBAction func signOutPressed(_ sender: UIButton) {
        FirebaseBrain.manager.logOut()
    }
}

extension MessageViewController: FirebaseBrainDelegate {
    func messageRetrieved(message: String) {
        messageLabel.text = message
        messageLabel.typingTimeInterval = 0.05
        messageLabel.startTypewritingAnimation()
    }
    
    func messageFailed(error: Error) { self.showAlert(message: error.localizedDescription) }
    func didSignOut() { dismiss(animated: true) }
    func failToSignOut(error: Error) { self.showAlert(message: error.localizedDescription) }
}
