//
//  MapMarkerController.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/05/29.
//  Copyright © 2020 wimes. All rights reserved.
//

import Foundation

protocol MapMarkerDelegate {
    func createMarker()
}

// 최종적으로 이녀석이 하는 일은 기본적으로 갖춰져 있는 MapMarker의 모습
// 그리고 createMarker를 이용해 delegate 하는 쪽에서 원하는 Marker의 모습을 만들어 줘야함.
class MapMarkerController{
    var markerCoordinator = MapCoordinator()
    var delegate: MapMarkerDelegate!
//    var dataSource: MapMarkerDelegate!    
}
