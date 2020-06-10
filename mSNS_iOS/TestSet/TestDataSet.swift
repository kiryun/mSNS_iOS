//
//  TestDataSet.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/06/10.
//  Copyright © 2020 wimes. All rights reserved.
//

import Foundation

//func httpPostMarker(header: Dictionary<String, Any>, body: Dictionary<String, Any>, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void){
//
////    //일단 무조건 석세스 띄우고 data안에는 json 넣자
////    let res: URLResponse = URLResponse(url: <#T##URL#>, mimeType: <#T##String?#>, expectedContentLength: <#T##Int#>, textEncodingName: <#T##String?#>)
////    completionHandler()
//
//}

func httpPostMarker() -> String{
    let json: String = """
    {
        "data_set": [
            {
                "lat": 123.1,
                "lon": 123.1,
                "u_id": 1,
                "article_id": 1,
                "gist_list": [
                    { "lat": 111.1, "lon": 111.1 },
                    { "lat": 111.2, "lon": 111.2 },
                    { "lat": 111.3, "lon": 111.3 }
                ]
            
            },
            {
                "lat": 100.1,
                "lon": 100.1,
                "u_id": 1,
                "article_id": 2,
                "gist_list": [
                    { "lat": 101.1, "lon": 101.1 },
                    { "lat": 101.2, "lon": 101.2 },
                    { "lat": 101.3, "lon": 101.3 }
                ]

            }

        ]
    }
    """
    return json
}
