//
//  RequestManager.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/07/08.
//  Copyright © 2020 wimes. All rights reserved.
//

import Foundation

class RequestManager{
    static let shared = RequestManager()
    let apiClient = ApiClient()
    typealias completion = (Data?, URLResponse?, Error?) -> Void
    
    private init(){
        
    }
    
    enum Requests{
        case SIGN_IN
        case SIGN_OUT
    }
    
    func request(identifier: Requests, param: [String: Any]?, completionHandler: @escaping completion) {
        switch identifier {
        case .SIGN_IN:
            let builder = ComponentBuilder()
            let director = ExternalComponentDirector(builder: builder)
            let url = director
                .setHost(host: Configure.baseURL)
                .setPath(path: URLs.SIGN_IN.rawValue)
                .build()
            
//            self.apiClient._post(url: <#T##URL#>, body: <#T##NSMutableDictionary#>, completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>)
        case .SIGN_OUT:
            let builder = ComponentBuilder()
            let director = ExternalComponentDirector(builder: builder)
            let url = director
                .setHost(host: Configure.baseURL)
                .setPath(path: URLs.SIGN_IN.rawValue)
                .build()
            
            self.apiClient._get(url: url, completionHandler: completionHandler)
        }
    }
    
}
