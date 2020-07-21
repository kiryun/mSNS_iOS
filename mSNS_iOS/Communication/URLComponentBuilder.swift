//
//  URLComponentBuilder.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/04/12.
//  Copyright © 2020 wimes. All rights reserved.
//

import Foundation

protocol ComponentBuilderProtocol
{

    var components: URLComponents { get set }

    func build () -> URL
    
}

protocol ComponentDirectorProtocol {
    var builder : ComponentBuilderProtocol {get set}
    
    func setPath(path : String) -> ComponentDirector
    func addQueryItem(name: String, value: String) -> ComponentDirector
    
    func build() -> URL
}

class ComponentBuilder : ComponentBuilderProtocol
{
    var components = URLComponents.init()

    func build() -> URL {
        print("ComponentBuilder generate")
        print("ComponentBuilder : " + self.components.url!.absoluteString)
        return self.components.url!
    }
}

class ComponentDirector : ComponentDirectorProtocol
{
    var builder: ComponentBuilderProtocol
    
    
    init(builder : ComponentBuilderProtocol) {
        print("ComponentDirector generate")
        self.builder = builder
        self.builder.components.scheme = "http"
//        self.builder.components.scheme = "https"
        self.builder.components.port = 3000
    }
    
    func setPath(path: String) -> ComponentDirector{
        var path = path
        if !path.hasPrefix("/") {
            path = "/" + path
        }
        self.builder.components.path = path
        return self
    }
    
    
    func addQueryItem(name: String, value: String) ->ComponentDirector{
        let path_component:String = "{"+name+"}"
        
        if self.builder.components.queryItems == nil {
            self.builder.components.queryItems = []
        }
        print(self.builder.components.path)
        if(self.builder.components.path.contains(path_component))
        {
            self.builder.components.path = self.builder.components.path.replacingOccurrences(of: path_component, with: value)
        }
        else{
            self.builder.components.queryItems?.append(URLQueryItem(name: name, value: value))
        }
        return self
    }
    
    func build() -> URL {
        print(self.builder.components.host)
        return self.builder.build()
    }
}

class ExternalComponentDirector : ComponentDirector
{
    
    override init(builder: ComponentBuilderProtocol) {
        print("ExternalComponentDirector generate")
        super.init(builder: builder)
    }
    
    func setHost(host: String) -> ComponentDirector
    {
        
        self.builder.components.host = host
        

        return self
    }
    
    override func build() -> URL {
        print("external : " + self.builder.components.url!.absoluteString)
        return self.builder.build()
    }
    
}
