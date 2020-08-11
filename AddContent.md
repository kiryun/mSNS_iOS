# Add Content

## BottomSheetView

현재 App의 rootView라고 할 수 있는 BottomSheetView에 Add button을 넣을 것이다.

```swift
import SwiftUI

struct BottomTabView: View {
    
    @ObservedObject private var tabData = BottomTabBarData(initialIndex: 1, itemIndex: 3)
    
    var body: some View {
        TabView (selection: self.$tabData.itemSelected){
            MapView()
                .tabItem {
                    Image(systemName: "location")
                    Text("Map")
            }
            .tag(1)
            RankView()
                .tabItem {
                    Image(systemName: "location")
                    Text("Rank")
            }
            .tag(2)
            
            Text("add")
                .tabItem {
                    Image(systemName: "plus.circle")
                    Text("Picture")
            }
            .tag(3)
            
            ArticleView()
                .tabItem {
                    Image(systemName: "cloud")
                    Text("Follow")
            }
            .tag(4)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
            }
            .tag(5)
        }
//        .sheet(isPresented: self.$tabData.isItemSelected) {
//            Text("message")
//        }
        .actionSheet(isPresented: self.$tabData.isItemSelected) {

            return ActionSheet(title: Text("Title"),
                        message: Text("Message"),
                        buttons: [.default(Text("Option 1"), action: self.option1),
                                  .default(Text("Option 2"), action: self.option2) ,
                                  .cancel()]
            )
        }
        
    }

    func option1(){
        self.tabData.reset()
    }
    
    func option2(){
        self.tabData.reset()
    }
}
```

<img src="/Users/gihyunkim/Library/Application Support/typora-user-images/image-20200810205328765.png" alt="image-20200810205328765" style="zoom: 33%;" />

> # Bug
>
> 원하는 모습은 위와 같은데 현재 constraint error 가 출력되고 있다.
>
> https://developer.apple.com/forums/thread/132172 
>
> ![image-20200810205405711](/Users/gihyunkim/Library/Application Support/typora-user-images/image-20200810205405711.png)
>
> 다른 사례들을([링크1](https://developer.apple.com/forums/thread/132172 ), [링크2](https://www.reddit.com/r/iOSProgramming/comments/cwv1ab/unable_to_simultaneously_satisfy_constraints_for/), [링크3](https://stackoverflow.com/questions/55372093/uialertcontrollers-actionsheet-gives-constraint-error-on-ios-12-2-12-3))을 들어본 결과 현재로서는 apple 측에서 발생하는 버그라고 판단되어진다.
>
> >  ## 시도 1
> >
> > https://github.com/no-more-coding/SwiftUI_Intuition_Library/blob/master/Markdowns/modifier_ActionSheet.md 을 참고
> >
> > 안됨 어차피 ActionSheet이라 되지 않는다.
>
> > ## 시도 2
> >
> > https://github.com/AndreaMiotto/ActionOver
> >
> > 얘도 마찬가지로 iPad Pro(4th, ipadOS 13.6), Simulator (iPhone 11 XS Max, iOS 13.6) 둘다 constraint error 출력
>
> > ## 결론
> >
> > Simulator와 iPad에서는 제대로 동작하지 않지만 일단 실기기(iPhone 8, iOS 13.6)에서는 잘동작함.
> >
> > 일단은 기본 ActionSheet을 사용하는 것으로 일단락.



## Only Text 





## Camera (Custom Camera )

참고: https://stackoverflow.com/questions/58847638/swiftui-custom-camera-view

SwiftUI에서 Camera를 사용하는 것은 아직 지원하지 않는다. 이는 UIKit을 이용해 사용해야하며 그 내용은 다음과 같다.



## Album ( Custom Image Picker )

