//
//  RankView.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/06/25.
//  Copyright © 2020 wimes. All rights reserved.
//

import SwiftUI

struct RankView: View {
    var body: some View {
        GeometryReader{ g in
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 10){
                    RankLayoutCase1()
                    RankLayoutCase2()
                }.frame(width: g.size.width, height: g.size.height)
            }
        }
    }
}

struct RankLayoutCase1: View {
    var body: some View{
        GeometryReader{ g in
            VStack{
                GeometryReader{ ge in
                    HStack{
                        Rectangle()
                            .fill(Color.red)
                            .frame(width: ge.size.width/2, height: ge.size.height)
                        Rectangle()
                            .fill(Color.orange)
                            .frame(width: ge.size.width/2, height: ge.size.height)
                    }
                }.frame(width: g.size.width, height: g.size.height/2)
                
                GeometryReader{ geo in
                    HStack{
                        GeometryReader{ geom in
                            VStack{
                                Rectangle()
                                    .fill(Color.yellow)
                                    .frame(width: geom.size.width, height: geom.size.height/2)
                                Rectangle()
                                    .fill(Color.green)
                                    .frame(width: geom.size.width, height: geom.size.height/2)
                            }
                            
                        }.frame(width: geo.size.width/2, height: geo.size.height)
                        
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: geo.size.width/2, height: geo.size.height)
                    }
                    
                }.frame(width: g.size.width, height: g.size.height/2)
                
            }
        }
    }
}

struct RankLayoutCase2: View {
    var body: some View{
        GeometryReader{ g in
            VStack{
                GeometryReader{ ge in
                    HStack{
                        Rectangle()
                            .fill(Color.red)
                            .frame(width: ge.size.width/2, height: ge.size.height)
                        Rectangle()
                            .fill(Color.orange)
                            .frame(width: ge.size.width/2, height: ge.size.height)
                    }
                }.frame(width: g.size.width, height: g.size.height/2)
                
                GeometryReader{ geo in
                    HStack{
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: geo.size.width/2, height: geo.size.height)
                        
                        GeometryReader{ geom in
                            VStack{
                                Rectangle()
                                    .fill(Color.yellow)
                                    .frame(width: geom.size.width, height: geom.size.height/2)
                                Rectangle()
                                    .fill(Color.green)
                                    .frame(width: geom.size.width, height: geom.size.height/2)
                            }
                            
                        }.frame(width: geo.size.width/2, height: geo.size.height)
                        
                        
                    }
                    
                }.frame(width: g.size.width, height: g.size.height/2)
                
            }
        }
    }
}
