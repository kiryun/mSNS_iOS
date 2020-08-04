//
//  BottomTabView.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/04/16.
//  Copyright © 2020 wimes. All rights reserved.
//

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
        .sheet(isPresented: self.$tabData.isItemSelected) {
            Text("message")
        }
//        .actionSheet(isPresented: self.$tabData.isItemSelected) {
//
//            return ActionSheet(title: Text("Title"),
//                        message: Text("Message"),
//                        buttons: [.default(Text("Option 1"), action: self.option1),
//                                  .default(Text("Option 2"), action: self.option2) ,
//                                  .cancel()]
//            )
//        }
        
    }

    func option1(){
        self.tabData.reset()
    }
    
    func option2(){
        self.tabData.reset()
    }
}

