//
//  ApiConfigure.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/04/12.
//  Copyright © 2020 wimes. All rights reserved.
//

import Foundation

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}

struct Configure {
    static let baseURL: String = "http://localhost:3000"
}

enum URLs : String {
    case LOGIN = "/accounts/v3/global/login"
    //set은 post get은 get으로 Method 지정
    
    func setHostWithPathComponentURL(pathvalues : NSMutableDictionary?) -> String {
        var path = self.rawValue
        if((pathvalues) != nil) {
            for key in (pathvalues)! {
                
                var find_value:String = "{%@}"
                find_value = find_value.replacingOccurrences(of: "%@", with: key.key as! String)
                
                path = path.replacingOccurrences(of: find_value, with: key.value as! String)
            }
        }
        return path
    }
}
