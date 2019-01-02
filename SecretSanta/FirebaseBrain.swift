//
//  FirebaseBrain.swift
//  SecretSanta
//
//  Created by C4Q on 12/31/18.
//  Copyright © 2018 C4Q. All rights reserved.
//


import Foundation
import Firebase
import CodableFirebase

protocol FirebaseBrainDelegate: class {
    func didSignIn()
    func failToSignIn(error:Error)
    func messageRetrieved(message: String)
    func messageFailed(error:Error)
    func didSignOut()
    func failToSignOut(error:Error)
}

extension FirebaseBrainDelegate {
    func didSignIn() {}
    func failToSignIn(error:Error) {}
    func messageRetrieved(message: String) {}
    func messageFailed(error:Error) {}
    func didSignOut() {}
    func failToSignOut(error:Error) {}
}

class FirebaseBrain {
    static let manager = FirebaseBrain()
    private var userRef = Database.database().reference().child("users")
    private init () {}
    weak var delegate: FirebaseBrainDelegate?
    private let auth = Auth.auth()
    
    func logIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                self.delegate?.failToSignIn(error: error)
            } else {
                self.delegate?.didSignIn()
            }
        }
    }
    
    func logOut() {
        do {
            try auth.signOut()
            self.delegate?.didSignOut()
        } catch {
            self.delegate?.failToSignOut(error: error)
        }
    }
    
    func getMessage() {
        guard let user = Auth.auth().currentUser else { return }
        let ref = userRef.child(user.uid)
        ref.observeSingleEvent(of: .value) { (snapshot) in
            guard let value = snapshot.value else { return }
            do {
                let message = try FirebaseDecoder().decode(FellowMessage.self, from: value).message
                self.delegate?.messageRetrieved(message: message)
            } catch let error {
                self.delegate?.messageFailed(error: error)
            }
        }
    }
}
