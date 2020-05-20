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
    var locationManager = CLLocationManager()
    var mapView: GMSMapView!
    let defaultLocation = CLLocation(latitude: 42.361145, longitude: -71.057083)
    var zoomLevel: Float = 14.0
    
    //marker
    let marker: MapMarker = MapMarker() // marker initializer
//    var marker: GMSMarker = GMSMarker()
    
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
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    
    //temporary
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
    
    
    /// Marker 관련
    // ref: https://stackoverflow.com/questions/39315219/custom-marker-with-user-image-inside-the-pin
    // 사용자가 map을 변경시킬 때 마다 marker가 다르게 표출되어야 한다.
    // GCD로 이 문제 해결이 가능할까?
    
    // marker 생성 GCD 이용해서 여러개 생성 하는 부분
    func createMarker(){
        self.mapView.selectedMarker = self.marker
//        self.setupMarker()
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
