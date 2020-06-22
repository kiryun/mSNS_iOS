# SignIn

Splash View 가 끝나고 앱이 실행되는 플로우를 보면 아래와 같다.



SignIn은 SignIn Providers(Google, FB 등) 를 보여주고 provider를 통해 로그인을 도와준다.



우선 SignInView 를 먼저 보도록 한다.

```swift
import SwiftUI

struct SignInView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<SignInView>) -> SignInViewController {
        return SignInViewController()
    }
    
    func updateUIViewController(_ uiViewController: SignInViewController, context: UIViewControllerRepresentableContext<SignInView>) {
        
    }
}
```

LoginView는 LoginViewController를 SwiftUI에서 사용할 수 있도록 도와주는 View이다.



실질적인 SignIn을 도와주는 SignInViewController를 보도록 하자.

**SignInViewController.swift**

```swift
import Foundation
import UIKit
import GoogleSignIn
import Firebase

class SignInViewController: UIViewController{
    let gButton: GIDSignInButton = GIDSignInButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Google sign in
        GIDSignIn.sharedInstance()?.presentingViewController = self
        // Automatically sign in the user.
//        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
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
```

GoogleSignIn을 UIKit 방식으로 구현을 해놓았고 `getUserData()` 메서드, FirebaseAuth의 기능을 활용해 User의 data를 받아올 수 있도록 구현했다.



## SignOut 

SignOut은 ProfileView에 구현을 했다.

**ProfileView.swift**

```swift
import SwiftUI
import Firebase
//import FBSDKLoginKit

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
//            AccessToken.current = nil
//            LoginManager().logOut()
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
```

FirebaseAuth를 이용해 SignOut을 완료하면 ( `Auth.auth().signOut()` ) sceneDelegate.window의 rootViewController를 SignInView로 바꿔 주도록 한다.(**한가지 아이디어로 splashView로 바꾸는 건 어떨지... **)





