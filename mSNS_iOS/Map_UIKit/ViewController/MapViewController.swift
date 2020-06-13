//
//  GoogleMapController.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/05/20.
//  Copyright © 2020 wimes. All rights reserved.
//



import Foundation
import CoreLocation
import UIKit
import GoogleMaps

// MapView 의 UI를 책임지는 부분
// Map -> {(MapMarker, ) -> MapViewController} -> MapView 형태임
// { Model -> ViewController, View }(UIKit) -> View(SwiftUI)
class MapViewController: UIViewController, CLLocationManagerDelegate{
    //map관련 model
    var markerCoordinator: MarkerCoordinator = MarkerCoordinator()
    var locationManager = CLLocationManager()
    var mapView: GMSMapView!
    //나중에 지워야 하는 값
    let defaultLocation = CLLocation(latitude: 42.361145, longitude: -71.057083)
    var nowLocation = CLLocation()
    var zoomLevel: Float = 14.0
    
    //marker
    //marker는 지울 것
    let marker: MapMarker = MapMarker() // marker initializer
    var markers: [MapMarker] = [MapMarker]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 위치 추적 권한 요청
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        // 위치 업데이트
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        // 현 위치 값 받아오기
        guard let lat = self.locationManager.location?.coordinate.latitude, let lon = self.locationManager.location?.coordinate.longitude else {
            return
        }
        
        //test
        self.reverseGeocoding()

        // 현위치 값으로 카메라 업데이트
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: zoomLevel)
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = true
        mapView.settings.compassButton = true
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
        mapView.settings.rotateGestures = true
        mapView.settings.tiltGestures = true
        mapView.isIndoorEnabled = false

        //marker
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        marker.map = mapView
        self.createMarker()

        view.addSubview(mapView)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
          print("Location access was restricted.")
        case .denied:
          print("User denied access to location.")
          // Display the map using the default location.
          mapView.isHidden = false
        case .notDetermined:
          print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
          print("Location status is OK.")
//        @unknown default:
//            //fatalerror
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    
    //test
    func reverseGeocoding(){
        // 경기도 수원시 장안구 수성로364번길 3 -> 37.293418, 127.011916
        // 경기도 성남시 분당구 삼평동 대왕판교로645번길 -> 37.400214, 127.104215
        guard let lat = self.locationManager.location?.coordinate.latitude, let lon = self.locationManager.location?.coordinate.longitude else {
            return
        }
        
        let location = CLLocation(latitude: lat, longitude: lon)
        let geo: Geocoding = Geocoding()
        geo.reverseGeocode(location: location) { placemark, error in
            if let error = error as? CLError {
                print("CLError:", error)
                return
            } else if let placemark = placemark?.first {
                // you should always update your UI in the main thread
                DispatchQueue.main.async {
                    print("neighborhood:", placemark.subLocality ?? "unknown")
                    print("city:", placemark.locality ?? "unknown")

                    print("state:", placemark.administrativeArea ?? "unknown")
                    print("country:", placemark.country ?? "unknown", terminator: "\n\n")
                    
                }
            }
        }
    }
    
}

extension MapViewController{
     /// Marker 관련
    // ref: https://stackoverflow.com/questions/39315219/custom-marker-with-user-image-inside-the-pin
    // 사용자가 map을 변경시킬 때 마다 marker가 다르게 표출되어야 한다.
    // GCD로 이 문제 해결이 가능할까?
    
    // marker 생성 GCD 이용해서 여러개 생성 하는 부분
    // crateMarker를 MapMarker 안으로 옮겨야 함
    // self.smapMarker는 [GMSMarker] 형태
    func createMarker(){
        // 현재 화면에 보여지고 있는 marker list 가져오기
        guard let currentLocation = self.locationManager.location?.coordinate else{
            return
        }
        let currentZoom = self.mapView.camera.zoom
        
        //MarkerData + markerCoordinator -> MapMarker
        guard let markerDataSet: MarkerDataSet = self.markerCoordinator.testDataSet() else{
            return
        }
        
        // M-V-C 에서 Model과 View는 서로 직접적으로 커뮤니케이션해서는 안됨.
        // Controller에서 View(Marker)에 대한 정보를 넣어줘야함
        print(markerDataSet.data_set[0].lat)
        for each in markerDataSet.data_set{
            let tempMarker = MapMarker()
            
            tempMarker.position.latitude = each.lat
            tempMarker.position.longitude = each.lon
            
            self.markers.append(tempMarker)
        }
        
        
        self.mapView.selectedMarker = self.marker
//        self.setupMarker()
    }

    // gistList의 값으로 (현재 보여지고 있는 화면에만) 폴리곤 그려줘야함.
    // 아 이거 마커에 data다들어있어서 MapView에서 Marker를 컨트롤 하는게 아닌거 같음.
    // 따로 MarkerController 만들어서 delegate, dataSource 이용해서 MapView에서 표현해주도록 하는게 맞는듯 함.
    func gistDraw(){
        
    }
    
    // marker 특성을 정의
    func setupMarker(){
        // building custom marker
        let markerImage = UIImage(named: "bg_visit")!.withRenderingMode(.alwaysTemplate)
        
        // creating a marker view
        let markerView = UIImageView(image: markerImage)
        self.marker.iconView = markerView
        self.mapView.selectedMarker = marker
    }
}
