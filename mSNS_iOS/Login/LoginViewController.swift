//
//  LoginViewController.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/06/20.
//  Copyright © 2020 wimes. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn
import Firebase

class LoginViewController: UIViewController{
    let gButton: GIDSignInButton = GIDSignInButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Google sign in
        GIDSignIn.sharedInstance()?.presentingViewController = self
        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        self.drawGoogleButton()
    }
    
    func drawGoogleButton(){
        //sign in
        self.gButton.style = .wide
        
        self.gButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.gButton)
        let centerX: NSLayoutConstraint = self.gButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        let centerY: NSLayoutConstraint = self.gButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        
        centerX.isActive = true
        centerY.isActive = true
    }
}

extension LoginViewController{
    func getUserData(){
        // signIn이 완료 되었을 때 handle을 통해 현재 사용자 정보를 가져올 수 있다.
        let handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let apnsToken = auth.apnsToken{
                print("LoginViewController/getGoogleUserData().auth.signIn.hanlde.auth.apnsToken: \(apnsToken)")
            }else{
                print("LoginViewController/getGoogleUserData().auth.signIn.hanlde.auth.apnsToken: apnsToken is nil")
            }
        }
    }
}
