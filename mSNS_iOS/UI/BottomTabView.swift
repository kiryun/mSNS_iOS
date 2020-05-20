//
//  BottomTabView.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/04/16.
//  Copyright © 2020 wimes. All rights reserved.
//

import SwiftUI

struct BottomTabView: View {
    var body: some View {
        TabView{
            MapView()
                .tabItem {
                    Image(systemName: "location")
                    Text("Map")
            }
            
            AddView()
                .tabItem {
                    Image(systemName: "alarm")
                    Text("Picture")
            }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "cloud")
                    Text("Profile")
            }
        }
    }
}

struct BottomTabView_Previews: PreviewProvider {
    static var previews: some View {
        BottomTabView()
    }
}
