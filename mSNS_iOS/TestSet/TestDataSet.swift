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
                "lat": -33.86,
                "lon": 151.20,
                "u_id": 1,
                "article_id": 1,
                "gist_list": [
                    { "lat": -33.70, "lon": 151.30 },
                    { "lat": -34.0, "lon": 152.0 },
                    { "lat": -34.1, "lon": 152.1 }
                ]
            
            },
            {
                "lat": -35.86,
                "lon": 157.20,
                "u_id": 1,
                "article_id": 1,
                "gist_list": [
                    { "lat": -35.70, "lon": 157.3 },
                    { "lat": -36.0, "lon": 158.0 },
                    { "lat": -36.1, "lon": 158.1 }
                ]

            }

        ]
    }
    """
    return json
}
