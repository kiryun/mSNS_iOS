//
//  Utils.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/04/12.
//  Copyright © 2020 wimes. All rights reserved.
//

import Foundation

func jsonStringToDictionary(jsonString: String) -> [String: Any]?{
    if let data = jsonString.data(using: .utf8){
        do{
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        }catch{
            print(error.localizedDescription)
        }
    }
    return nil
}
