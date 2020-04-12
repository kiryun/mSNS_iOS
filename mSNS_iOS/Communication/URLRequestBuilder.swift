//
//  URLRequestBuilder.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/04/12.
//  Copyright © 2020 wimes. All rights reserved.
//

import Foundation

protocol RequestBuilderProtocol {
    var request : URLRequest {get set}
    init(url : URL)
    func build () -> URLRequest
    
}

protocol RequestDirectorProtocol {
    var builder : RequestBuilderProtocol {get set}
    func setMethod(method : String) -> RequestDirector
    func setHeader(headerDict : [String : String]) -> RequestDirector
}

class RequestBuilder : RequestBuilderProtocol
{
    var request: URLRequest
    
    required init(url: URL) {
        self.request = URLRequest(url: url)
    }
    
    func build() -> URLRequest {
        return self.request
    }
}

class RequestDirector : RequestDirectorProtocol
{
    var builder: RequestBuilderProtocol
    
    init(builder : RequestBuilderProtocol) {
        self.builder = builder
    }
    func setMethod(method: String) -> RequestDirector {
        self.builder.request.httpMethod = method
        return self
    }
    
    func setHeader(headerDict: [String : String]) -> RequestDirector {
        
        for (key, value) in headerDict {
            self.builder.request.setValue(key, forHTTPHeaderField: value)
        }
        return self
    }
    func build() -> URLRequest
    {
        self.builder.build()
    }
}
