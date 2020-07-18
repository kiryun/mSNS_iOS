//
//  SignInViewController.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/06/20.
//  Copyright © 2020 wimes. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import SwiftUI

class SignInViewController: UIViewController{
    let gButton: GIDSignInButton = GIDSignInButton()
    let fButton: FBLoginButton = FBLoginButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Google sign in
        GIDSignIn.sharedInstance()?.presentingViewController = self
        // Automatically sign in the user.
//        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        self.drawGoogleButton()
        
        //facebook sign in
        self.fButton.delegate = self
        self.drawFacebookButton()
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
    
    func drawFacebookButton(){
        self.fButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.fButton)
        
        let centerX: NSLayoutConstraint = self.fButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let yAnchor: NSLayoutConstraint = NSLayoutConstraint(item: self.fButton,
                                                             attribute: NSLayoutConstraint.Attribute.centerY,
                                                             relatedBy: NSLayoutConstraint.Relation.equal,
                                                             toItem: self.gButton,
                                                             attribute: NSLayoutConstraint.Attribute.bottom,
                                                             multiplier: 1.0,
                                                             constant: 20)
        
        centerX.isActive = true
        yAnchor.isActive = true
    }
}

extension SignInViewController{
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

extension SignInViewController: LoginButtonDelegate{
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("FB did log out")
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if error != nil{
            print(error?.localizedDescription)
            return
        }else if result?.isCancelled == true{
            print("Cancelled")
        }else{
            // fb login 성공 시
            let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
            //accessToken: 같은 계정이라도 같은 값을 보장해주지는 않는다.
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if error != nil {
                    print(error?.localizedDescription)
                    return
                } else {
                    // User is signed in
                    print("FB signed in")
                    
                    User.shared.displayName = Auth.auth().currentUser?.displayName
                    
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let sceneDelegate = windowScene.delegate as? SceneDelegate else{
                        return
                    }
                    
                    sceneDelegate.window?.rootViewController = UIHostingController(rootView: BottomTabView())
                }
            }
        }
    }
}
