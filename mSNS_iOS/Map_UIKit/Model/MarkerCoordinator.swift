//
//  Map.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/04/20.
//  Copyright © 2020 wimes. All rights reserved.
//

import Foundation
import CoreLocation

class MarkerCoordinator{
    
    
    // Server에서 현재 보여지고 있는 지역에서 가장 핫한 마커 위치 가져오기
    func testDataSet() -> MarkerDataSet?{
        do{
            guard let json = httpPostMarker().data(using: .utf8) else { return nil}
            let markerDataSet: MarkerDataSet = try JSONDecoder().decode(MarkerDataSet.self, from: json)

            print(markerDataSet)
            return markerDataSet
        }catch{
            print(error)
        }
        return nil
    }
    
    // 서버에다 현재 지역에서 핫한 아티클(마커)들 요청하고 받은 data를 marker의 model대로 넣어야 함
    // 이건 closure? promise 에서 해봤던거 써볼 수 있을 듯 Data<Marker> 이런식으로
//    func getMarkerList(gps: CLLocationCoordinate2D, zoom: Float) -> [MarkerData]?{
//        let lat = gps.latitude
//        let lon = gps.longitude
//        let zoomLevel = zoom // 이부분 zoom level로 변경해줘야 함
//        //url builder set
//        let builder = ComponentBuilder()
//        let director = ExternalComponentDirector(builder: builder)
//        let url = director
//            .setHost(host: URLs.LOGIN.rawValue)
//            .setPath(path: "")
//            .addQueryItem(name: "", value: "")
//            .build()
//
//        //request & response
//        let tempDict: NSMutableDictionary = NSMutableDictionary()
//        tempDict["lat"] = lat
//        tempDict["lon"] = lon
//        tempDict["zoom_level"] = zoomLevel
//        if let uID = User.shared.uID{
//            tempDict["uid"] = uID
//        }
//
//        var marker: [MarkerData]? = nil
//        self.apiClient.post(url: url, body: tempDict)
//            .onSuccess { res in
//                print(res) // json parsing 후 map에 찍히는 marker들에 대한 sturct에 저장 할 것
////                marker?.append(MarkerData(lat: <#T##Double?#>, lon: <#T##Double?#>, gistList: <#T##[Double]?#>, uID: <#T##Int?#>, articleID: <#T##Int?#>))
//        }
//        .onFailure { err in
//            print(err.localizedDescription)
//        }
//
//        return marker
//    }
}

struct MarkerDataSet: Codable{
    var data_set: [MarkerData]
    struct MarkerData: Codable {
        var lat: Double
        var lon: Double
        var u_id: Int
        var article_id: Int
        var gist_list: [Gist]
        struct Gist: Codable{
            var lat: Double
            var lon: Double
        }
    }
    
}
