//
//  GDAMCoordinate.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/04/27.
//  Copyright © 2020 wimes. All rights reserved.
//

import Foundation

class GADMCoordinate{
    var apiClient: ApiClient = ApiClient()
    let gadmURL: URL = URL(string: "https://gadm.org/country")!
    
    init() {
        
    }
    
    func getGADMData(){
        self.apiClient.get(url: gadmURL)
            .onSuccess { data in
                
        }
        .onFailure { error in
            
        }
    }
    
    func xmlParser(region: String){
        
    }
}
