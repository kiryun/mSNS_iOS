//
//  RequestManager.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/07/08.
//  Copyright © 2020 wimes. All rights reserved.
//

import Foundation

enum RequestIdentifier{
    case TEST
    case SIGN_IN
    case SIGN_OUT
    
    var meghod: String{
        switch self {
        case .TEST:
            return "GET"
        case .SIGN_IN:
            return "POST"
        case .SIGN_OUT:
            return "POST"
        }
    }
}

typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

protocol RequestManagerProtocol {
    func isOverlapRequest(with enum: RequestIdentifier) -> Bool
    func appendRequest(with enum: RequestIdentifier, pram: [String: Any]?, completionHandler: @escaping CompletionHandler)
}

class RequestManager{
    let apiClient = ApiClient()
    
    init(){
        
    }
    
    func request(identifier: RequestIdentifier, param: [String: Any]? = nil, completionHandler: @escaping CompletionHandler) {
        switch identifier {
        case .TEST:
            let builder = ComponentBuilder()
            let director = ExternalComponentDirector(builder: builder)
            let url = director
                .setHost(host: "jsonplaceholder.typicode.com")
                .setPath(path: "todos/1")
                .build()
            self.apiClient._get(url: url, completionHandler: completionHandler)
            
        case .SIGN_IN:
            let builder = ComponentBuilder()
            let director = ExternalComponentDirector(builder: builder)
            let url = director
                .setHost(host: Configure.baseURL)
                .setPath(path: URLs.SIGN_IN.rawValue)
                .build()
            
            if let p = param{
                self.apiClient._post(url: url, body: p, completionHandler: completionHandler)
            }
            
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
