//
//  RankViewModel.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/06/30.
//  Copyright © 2020 wimes. All rights reserved.
//

import Foundation

class RankViewModel: ObservableObject{
    let apiClient = ApiClient()
    let dGroup = DispatchGroup()
    
    // rankView에서 스크롤 할 때마다 ? 호출되는 메서드
    // 논의 필요) 각 Cell마다 모두 받아와야지 보여지는게 아닌 바로바로 보여질 수 있도록 vs 모두 받아와야지 보여지는 지 
    func requestArticles(){
        DispatchQueue.global(qos: .background).async {
            self.dGroup.enter()
            // 서버에서 받아온 article을 모두 받았다면 leave()
            
            
        }
        dGroup.notify(queue: DispatchQueue.main){
            // article이 모두받았을 때 실행되는 로직
            // RankViewCell에 content들이 채워지고 화면이 다시 재생성 되는 것
        }
    }
}
