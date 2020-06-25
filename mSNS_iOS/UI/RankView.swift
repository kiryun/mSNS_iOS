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
        VStack{
            GeometryReader{ g in
                HStack{
                    GeometryReader{ ge in
                        Rectangle()
                            .fill(Color.red)
                            .frame(width: ge.size.width/2, height: ge.size.height)
                        Rectangle()
                            .fill(Color.orange)
                            .frame(width: ge.size.width/2, height: ge.size.height)
                    }
                }.frame(width: g.size.width, height: g.size.height/2)
                
                HStack{
                    GeometryReader{ geo in
                        VStack{
                            GeometryReader{ geom in
                                Rectangle()
                                    .fill(Color.yellow)
//                                    .frame(width: goem.size.width, height: goem.size.height/2)
                                Rectangle()
                                    .fill(Color.green)
//                                    .frame(width: goem.size.width, height: goem.size.height/2)
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

struct RankView_Previews: PreviewProvider {
    static var previews: some View {
        RankView()
    }
}
