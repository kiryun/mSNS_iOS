//
//  ArticleView.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/07/05.
//  Copyright © 2020 wimes. All rights reserved.
//

import SwiftUI

struct ArticleView: View {
    var body: some View {
        GeometryReader{ g in
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    ArticleImageView()
                        .frame(width: g.size.width, height: g.size.height * 0.7)
                    Article()
                        .frame(width: g.size.width, height: g.size.height * 0.3)
                }
                
            }
        }
        
    }
}

struct ArticleImageView: View{
    var body: some View{
        Rectangle()
            .fill(Color.green)
    }
}

struct Article: View{
    var body: some View{
        Rectangle()
            .fill(Color.blue)
    }
}
