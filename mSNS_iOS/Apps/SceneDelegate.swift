//
//  SceneDelegate.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/04/12.
//  Copyright © 2020 wimes. All rights reserved.
//

import UIKit
import SwiftUI
import Firebase
import GoogleSignIn
import FBSDKCoreKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate, GIDSignInDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Create the SwiftUI view that provides the window contents.
//        let rootView = BottomTabView()
//
//        // Use a UIHostingController as window root view controller.
//        if let windowScene = scene as? UIWindowScene {
//            let window = UIWindow(windowScene: windowScene)
//            window.rootViewController = UIHostingController(rootView: rootView)
//            self.window = window
//            window.makeKeyAndVisible()
//        }
        
        // GoogleSignIn initialize
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
        
        if let windowScene = scene as? UIWindowScene {
                    let window = UIWindow(windowScene: windowScene)
                    
                    
                    if Auth.auth().currentUser != nil{
                        User.shared.displayName = Auth.auth().currentUser?.displayName
                        window.rootViewController = UIHostingController(rootView: BottomTabView())
                    }else{
                        window.rootViewController = SignInViewController()
                    }
        //            window.rootViewController = UIHostingController(rootView: contentView)
                    self.window = window
                    window.makeKeyAndVisible()
                }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

// MARK: GIDSignInDelegate
extension SceneDelegate{
    // 해당 함수는 로그인 할 때 호출이 된다. 즉, 자동로그인 할 때 View를 어떻게 표현을 해줄 것인가를 여기서 설정해야함.
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        
        // Google SignIn
        if let error = error {
            // ...
            print("AppDelegate.sign().error = error")
            print("\(error.localizedDescription)")
            return
        }
        
        
        // Perform any operations on signed in user here.
        guard let authentication = user.authentication else { return }

        // return A FIRAuthCredential containing the Google credentials.
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                        accessToken: authentication.accessToken)
        
        // Finally
        // Firebase Auth signIn
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error{
                print("AppDelegate.sign().auth.signIn.error = error")
                print("\(error.localizedDescription)")
                return
            }
            
            // user is signed in
            // ...
            
            User.shared.displayName = Auth.auth().currentUser?.displayName
            
            print("AppDelegate.sign().auth.signIn.authResult.profile: \((authResult?.additionalUserInfo?.profile)!)")
            self.window?.rootViewController = UIHostingController(rootView: BottomTabView())
            self.window?.makeKeyAndVisible()
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
        print("sign didDisconnectWith")
    }
}

// MARK: Facebook
extension SceneDelegate{
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let openURLContext: UIOpenURLContext = URLContexts.first{
            ApplicationDelegate.shared.application(
                UIApplication.shared,
                open: openURLContext.url,
                sourceApplication: openURLContext.options.sourceApplication,
                annotation: openURLContext.options.annotation)
        }else{
            return
        }
    }
}
