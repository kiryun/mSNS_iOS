//
//  RequestManager.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/07/08.
//  Copyright © 2020 wimes. All rights reserved.
//

import Foundation

enum RequestIdentifier{
    case SIGN_IN
    case SIGN_OUT
    
    var method: String{
        switch self {
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
    
    init(){
        
    }
    
    func request(identifier: RequestIdentifier, body: [String: Any]? = nil, completionHandler: @escaping CompletionHandler) {
        switch identifier {
        case .SIGN_IN:
            let builder = ComponentBuilder()
            let director = ExternalComponentDirector(builder: builder)
            let url = director
                .setHost(host: Configure.baseURL)
                .setPath(path: URLs.SIGN_IN.rawValue)
                .build()
            
            if let b: [String: Any] = body{
                self.post(url: url, body: b, completionHandler: completionHandler)
            }
            
            
        case .SIGN_OUT:
            let builder = ComponentBuilder()
            let director = ExternalComponentDirector(builder: builder)
            let url = director
                .setHost(host: Configure.baseURL)
                .setPath(path: URLs.SIGN_IN.rawValue)
                .build()
            
            self.get(url: url, completionHandler: completionHandler)
        }
    }
    
}

// post get
extension RequestManager{
    func get(url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void){
        var request: URLRequest = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        
        URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
    }
    
    
    func post(url: URL, body: [String: Any], completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void){
        print(url)
        print(body)
        var request: URLRequest = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        do{
            let json = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            request.httpBody = json
        }catch{
            print("APIClient._post: \(error)")
        }
        
        URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
    }
}
