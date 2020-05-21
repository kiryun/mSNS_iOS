//
//  Map.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/04/20.
//  Copyright © 2020 wimes. All rights reserved.
//

import Foundation
import CoreLocation

class Map{
    let apiClient = ApiClient()
    
    // Server에서 현재 보여지고 있는 지역에서 가장 핫한 마커 위치 가져오기
    func getHotMarker(nowGPS: CLLocation){
        
    }
    
    // 서버에다 요청하고 받은 data를 marker의 model대로 넣어야 함
    // 이건 closure? promise 에서 해봤던거 써볼 수 있을 듯 Data<Marker> 이런식으로
    func getMarkerList(gps: CLLocationCoordinate2D, zoom: Float){
        var lat = gps.latitude
        var lon = gps.longitude
//        self.apiClient
        
    }
}
