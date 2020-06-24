# FirebaseAuth

* **프로젝트 생성/App 추가 이후 내용만을 다루도록 한다.**
* **FirebaseUI를 사용하면 앱 자체의 용량이 너무 커지므로 Firebase를 사용하도록 한다**



## 앱에 FirebaseAuth  추가

`vim Podfile` 로 Podfile을 수정하도록 한다.

추가하는 내용은`pod Firebase/Auth` 를 추가한다.

![image-20200620225248649](Auth.assets/image-20200620225248649.png)



**AppDelegate.swift**  에서 Firebase 사용을 위해 코드를 추가해준다.

```swift
import UIKit
import GoogleMaps
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let gmApiKey: String = "AIzaSyBp9p8TDjwGLsqTSJS8rmaw_6H9EYRWKdM"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey(self.gmApiKey)
        FirebaseApp.configure()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}
```



## GoogleSignIn 추가

인증 제공업체인 google signIn 을 추가하도록 한다.

마찬가지로 Podfile을 수정해주도록 한다.

`pod 'GoogleSignIn'`

Firebase Console에서 Authentication > Sign-in method  에서 Google을 추가하도록 한다.

![image-20200620230458016](Auth.assets/image-20200620230458016.png)



Xcode(TARGETS > Info > URL Types) 에서 반전된 클라이언트 ID를 URL 스키마로 추가한다. 이값은 GoogleService-Info.plist 에서 찾을 수 있다.

**GoogleService-Info.plis**

![image-20200620230645114](Auth.assets/image-20200620230645114.png)

**URL Schemes**

![image-20200620230822763](Auth.assets/image-20200620230822763.png)



**AppDelegate.swift**에서 `application:openURL:options:` 메서드를 구현한다. 이 메서드는 `GIDSignIn` 인스턴스의 `handleURL` 메서드를 호출하여 인증 프로세스가 끝날 때 애플리케이션이 수신하는 URL을 적절히 처리하는 기능을 수행한다.(**해당 메서드는 GoogleSignIn에서 제공하는 것이 아니다.**)

```swift
import UIKit
import GoogleMaps
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let gmApiKey: String = "AIzaSyBp9p8TDjwGLsqTSJS8rmaw_6H9EYRWKdM"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey(self.gmApiKey)
        FirebaseApp.configure()
        
        return true
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        // GID ref: https://developers.google.com/identity/sign-in/ios/sign-in?ver=swift
        guard let instance = GIDSignIn.sharedInstance() else {
            return false
        }
        print("\(url)")
        
        return instance.handle(url)
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}
```



이제 **SceneDelegate.swift**에서 SignIn 성공 시 최초로 보여줄 View를 설정해주는 로직을 `scene(_:willConnectTo:options:connectionOptions:)`에 구현할 것이다.

* SignIn 이 되었을 경우: MainView(BottomTabView)
* SignIn 이 되지 않았을 경우: LoginView

```swift
import UIKit
import SwiftUI
import Firebase
import GoogleSignIn

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
                        window.rootViewController = UIHostingController(rootView: BottomTabView())
                    }else{
                        window.rootViewController = LoginViewController()
                    }
        //            window.rootViewController = UIHostingController(rootView: contentView)
                    self.window = window
                    window.makeKeyAndVisible()
                }
    }

    // ... 생략


}
```

이제 GIDSignInDelegate protocol을 구현해주도록 한다.

```swift
extension SceneDelegate{
    // MARK: GIDSignInDelegate
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
```

각각 메서드를 살펴보도록 하자.

`sign(_:didSignInFor:withError:)` 메서드는 signIn에 성공했을 때 호출되는 delegate 메서드 이다.

이안에 googleSignIn idToken과 accessToken을 이용해 credential을 만든다. 

credential을 이용해 FirebaseAuth에 로그인하고 signIn에 성공했으면 rootViewController를 `BottomTabView` 로 지정한다.



`sign(_:didDisconnectWith:error:)` 메서드는 disconnect에 성공했을 때 호출되는 메서드이다.

현재 FirebaseAuth를 사용하고 있기 때문에 따로 내용을 채워줄 필요는 없다.

> **SignOut과 Disconnect 용어에 대한 정리**
>
> `GIDSignIn.sharedInsctance()` 를 살펴보면
>
> ```swift
> /// Marks current user as being in the signed out state.
> open func signOut()
> 
> 
> /// Disconnects the current user from the app and revokes previous authentication. If the operation
> /// succeeds, the OAuth 2.0 token is also removed from keychain.
> open func disconnect()
> ```
>
> signOut은 단순히 사용자를 로그아웃된 상태로 표시하는 것. **또한 SignOut은 아무런 delegate method를 호출하지 않는다.**
>
> disconnect는 현재 사용자를 앱에서 연결 해제하고 인증을 취소한다. disconnect 작업이 성공하면 OAuth2.0 토큰도 키체인에서 제거된다.
>
> 다시말해 Application에서는 더이상 Google OAuth 2.0 에 접근을 할 수 없는 상태가 되어버린다.



## FacebookSignIn  추가

[https://developers.facebook.com](https://developers.facebook.xn--com-k94n91q/) 에서 내앱 > 앱만들기를 클릭하여 프로젝트를 생성해준다.

cocopod을 이용해 SDK를 설치해준다.

`pod 'FBSDKLoginKit'`

제품 > Facebook 로그인을 추가한다.

iOS에서 설정을 완료해준다.(생략)



**AppDelegate.swift** 에서 `FBSDKCoreKit`  을 import 해주고 

`application(_ :open:options:) -> Bool` 를 구현해준다.

```swift
import FBSDKCoreKit

class AppDelegate: UIResponder, UIApplicationDelegate{
	  
  	// ... 중간 생략
  
		@available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        //Google SignIn
        // GID ref: https://developers.google.com/identity/sign-in/ios/sign-in?ver=swift
        guard let instance = GIDSignIn.sharedInstance() else {
            return false
        }
        
        let gid = instance.handle(url)
        
        //FacebookSignIn
        let fb = ApplicationDelegate.shared.application(
            application,
            open: (url as URL?)!,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        
        
        return gid || fb
    }
  
  	// ... 중간 생략
}
```

메서드를 구현하는데 다른 Auth 도 구현 하는게 있다면 반환값을 `||` 을 이용해 정해주도록 한다.



> iOS 13이상을 사용하는 경우**SceneDelegate.swift**  를 구현해준다.
>
> ```swift
> import FBSDKCoreKit
> // ... 생략
> 
> // for facebook
> extension SceneDelegate{
>  func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
>      if let openURLContext: UIOpenURLContext = URLContexts.first{
>          ApplicationDelegate.shared.application(
>              UIApplication.shared,
>              open: openURLContext.url,
>              sourceApplication: openURLContext.options.sourceApplication,
>              annotation: openURLContext.options.annotation)
>      }else{
>          return
>      }
>  }
> }
> ```



Firebase Console > Authentication > Sign-in method > Facebook에서 OAuth 리디렉션 URI를 가져와 Facebook Console > 설정 > 유효한 OAuth 리디렉션 URI 에 추가를 해줘야한다.

![image-20200624191526515](Auth.assets/image-20200624191526515.png)

![image-20200624191237848](Auth.assets/image-20200624191237848.png)



Facebook > 설정 > 기본설정에서 앱 ID와 앱 시크릿 코드를 가져와 Firebase Console > Authentication > Sign-in method > Facebook 에 넣어준다.

![image-20200624191655763](Auth.assets/image-20200624191655763.png)

![image-20200624191526515](Auth.assets/image-20200624191526515.png)



이제 로그인을 구현하도록 한다.

**SignInViewController.swift**

```swift
import FBSDKLoginKit
// 생략 ...

class SignInViewController: UIViewController{
    let gButton: GIDSignInButton = GIDSignInButton()
    let fButton = FBLoginButton()
  
  	override func viewDidLoad(){
        super.viewDidLoad()
        
        // Google sign in
        GIDSignIn.sharedInstance()?.presentingViewController = self
        // Automatically sign in the user.
//        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        self.drawGoogleButton()
        
        // Facebook sign in
	      self.fButton.delegate = self
        self.drawFacebookButton()
        
      	// 생략 ...
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
  
  	// 생략 ...
}
```



위코드는 UI를 구현한 것이고 실제 로그인을 구현한다.

**SignInViewController.swift**

```swift
// 생략 ...
import SwiftUI
// 생략 ...

// for facebook login
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
            
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if error != nil {
                    print(error?.localizedDescription)
                    return
                } else {
                    // User is signed in
                    print("FB signed in")
                  	guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let sceneDelegate = windowScene.delegate as? SceneDelegate else{
                        return
                    }
                    
                    sceneDelegate.window?.rootViewController = UIHostingController(rootView: BottomTabView())
                }
            }
        }
    }
}
```



로그아웃**ProfileView.swift**

```swift
import FBSDKLoginKit
// 생략

struct ProfileView: View {
    // 생략
    
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
```



<img src="Auth.assets/image-20200624215617569.png" alt="image-20200624215617569" style="zoom:25%;" />

실행을 해보면 이와같은 화면이 출력될텐데 이는 아직 개발중에서 live로 전환이 되지않아서 생기는 문제이다.

(아래 그림에서  상태가 현재 "개발 중"이다.)

![image-20200624215714375](Auth.assets/image-20200624215714375.png)



이 경우 개발자를 등록을 해줘야한다.

테스터 등록은 역할 > 역할 에서 등록할 수 있다.

![image-20200624215850043](Auth.assets/image-20200624215850043.png)

이제 개발자를 추가해야하는데 아래와 같은 화면이 출력될 것이다. 추가할 개발자의 username을 적어주면 되는데 페이스북 프로필 url  `facebook.com/{username}`  에서 username을 적어준다.

혹시나 username이 설정되어 있지 않거나 이상한 해쉬값으로 되어있다면 https://www.facebook.com/settings?tab=account&section=username 에서 username을 변경할 수 있다.

완료를 했으면 facebook에서 해당계정으로 로그인한다음 "확인"을 눌러주면 된다.

<img src="Auth.assets/image-20200624220417502.png" alt="image-20200624220417502" style="zoom:25%;" />

> 페이스북을 넣는 순간 google쪽 sign-in이 완전히 죽어버리는데 이경우 info > URLTypes > Scheme 을 다시 수정해주면 된다.
>
> ![image-20200624221527984](Auth.assets/image-20200624221527984.png)
>
> > 근데 다시 또 실행하면 이번에는 Facebook이 실행되지 않는다. 또한 info.list에 facebook에 대한 정보가 사라져 있다.
> >
> > ![image-20200624221431998](Auth.assets/image-20200624221431998.png)
> >
> > 아마 CFBundleURLTypes key 가 Google과 Facebook 이 중복으로 사용되고 있어서 그런거 같다.
> >
> > 다음과 같이 CFBundleURLtypes>Google 코드 밑에 Facebook 을 추가해주자.
> >
> > ```xml
> > <key>CFBundleURLTypes</key>
> > 	<array>
> >         <!--google-->
> > 		<dict>
> > 			<key>CFBundleTypeRole</key>
> > 			<string>Editor</string>
> > 			<key>CFBundleURLSchemes</key>
> > 			<array>
> > 				<string>com.googleusercontent.apps.asdf-asdf</string>
> > 			</array>
> > 		</dict>
> >         <!--facebook-->
> >         <dict>
> >             <key>CFBundleURLSchemes</key>
> >             <array>
> >                 <string>asdf</string>
> >             </array>
> >         </dict>
> > 	</array>
> > ```
> >
> > 마지막으로 facebook appID/ 대화상자를 열수있는 코드도 추가해주도록한다.
> >
> > ```xml
> > <key>FacebookAppID</key>
> >     <string>asdf</string>
> >     <key>FacebookDisplayName</key>
> >     <string>mSNS</string>
> >     
> >     <key>LSApplicationQueriesSchemes</key>
> >     <array>
> >         <string>fbapi</string>
> >         <string>fbapi20130214</string>
> >         <string>fbapi20130410</string>
> >         <string>fbapi20130702</string>
> >         <string>fbapi20131010</string>
> >         <string>fbapi20131219</string>
> >         <string>fbapi20140410</string>
> >         <string>fbapi20140116</string>
> >         <string>fbapi20150313</string>
> >         <string>fbapi20150629</string>
> >         <string>fbapi20160328</string>
> >         <string>fbauth</string>
> >         <string>fb-messenger-share-api</string>
> >         <string>fbauth2</string>
> >         <string>fbshareextension</string>
> >     </array>
> > ```



### Reference

* Logout: https://stackoverflow.com/questions/42011252/firebase-facebook-login-button-does-not-change-after-user-log-out
* sign-in
  * https://developers.facebook.com/apps/141477280607703/fb-login/quickstart/?sdk=cocoapods
  * https://velog.io/@wimes/Firebase-Auth
  * https://www.youtube.com/watch?v=W8NzdN0h50I