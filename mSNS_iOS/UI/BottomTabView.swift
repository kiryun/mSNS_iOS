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
    @State private var pickerFlag = false
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
            
            AddContentView()
                .tabItem {
                    Image(systemName: "plus.circle")
                    Text("AddContent")
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
        .actionSheet(isPresented: self.$tabData.isItemSelected) { () -> ActionSheet in
            return ActionSheet(title: Text("Add Content"),
                               buttons: [
                                .default(Text("Camera"), action: self.option1),
                                .default(Text("Picture"), action: self.option2),
//                                .destructive(Text("Cancel"), action: self.cancel)
                                .cancel(Text("Cancel"), action: self.cancel)
            ])
        }
        .sheet(isPresented: self.$pickerFlag) {
            AddContentView()
        }
        
    }
}

extension BottomTabView{
    func option1(){
        self.tabData.reset()
        self.pickerFlag = true
    }
    
    func option2(){
        self.tabData.reset()
    }
    
    func cancel(){
        self.tabData.reset()
    }
}
