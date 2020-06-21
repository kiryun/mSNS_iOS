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

