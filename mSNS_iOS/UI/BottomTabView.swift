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
    @State private var ImagePickerViewFlag = false
    @State private var cameraViewFlag = false
    @State private var image: UIImage?
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
                                .default(Text("Picture"), action: self.option1),
                                .default(Text("Camera"), action: self.option2),
//                                .destructive(Text("Cancel"), action: self.cancel)
                                .cancel(Text("Cancel"), action: self.cancel)
            ])
        }
//        .sheet(isPresented: self.$ImagePickerViewFlag) {
//            AddContentView()
//        }
        .sheet(isPresented: self.$cameraViewFlag) {
            CameraView(image: self.$image)
        }
        
    }
}

extension BottomTabView{
    func option1(){
        self.tabData.reset()
        self.ImagePickerViewFlag = true
    }
    
    func option2(){
        self.tabData.reset()
        self.cameraViewFlag = true
    }
    
    func cancel(){
        self.tabData.reset()
    }
}
