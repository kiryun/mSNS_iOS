//
//  ProfileView.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/04/16.
//  Copyright © 2020 wimes. All rights reserved.
//

import SwiftUI
import Firebase
import FBSDKLoginKit

struct ProfileView: View {
    var body: some View {
        VStack{
            Text("ProfileView")
            Button(action: self.signOut){
                Text("Sign out")
            }
        }
    }
    
    func signOut(){
        do{
            try Auth.auth().signOut()
            
            //facebook signout
            AccessToken.current = nil
            LoginManager().logOut()
        }catch let signOutError as NSError{
            print(signOutError)
        }
        
        // ref: https://gist.github.com/alexpaul/875d1c8ce45a5f536d0c81087285f4d8
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let sceneDelegate = windowScene.delegate as? SceneDelegate else{
            return
        }
        
        sceneDelegate.window?.rootViewController = UIHostingController(rootView: SignInView())
    }
}
