//
//  ContentView.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/04/12.
//  Copyright © 2020 wimes. All rights reserved.
//

import SwiftUI
import CoreLocation
import UIKit
import GoogleMaps

class GoogleMapController: UIViewController, CLLocationManagerDelegate{
    var locationManager = CLLocationManager()
    var mapView: GMSMapView!
    let defaultLocation = CLLocation(latitude: 42.361145, longitude: -71.057083)
    var zoomLevel: Float = 6.0
    let marker: GMSMarker = GMSMarker()
    
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
        mapView.setMinZoom(14, maxZoom: 20)
        mapView.settings.compassButton = true
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
        mapView.settings.rotateGestures = true
        mapView.settings.tiltGestures = true
        mapView.isIndoorEnabled = false

        //marker
        
//        marker.position = CLLocationCoordinate2D(latitude: 42.361145, longitude: -71.057083)
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        marker.title = "Boston"
        marker.snippet = "USA"
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
                    //  update UI here
//                    print("name:", placemark.name ?? "unknown")

//                    print("address1:", placemark.thoroughfare ?? "unknown")
//                    print("address2:", placemark.subThoroughfare ?? "unknown")
                    print("neighborhood:", placemark.subLocality ?? "unknown")
                    print("city:", placemark.locality ?? "unknown")

                    print("state:", placemark.administrativeArea ?? "unknown")
//                    print("subAdministrativeArea:", placemark.subAdministrativeArea ?? "unknown")
//                    print("zip code:", placemark.postalCode ?? "unknown")
                    print("country:", placemark.country ?? "unknown", terminator: "\n\n")

//                    print("isoCountryCode:", placemark.isoCountryCode ?? "unknown")
//                    print("region identifier:", placemark.region?.identifier ?? "unknown")
//
//                    print("timezone:", placemark.timeZone ?? "unknown", terminator:"\n\n")

                    // Mailind Address
//                    print(placemark.mailingAddress ?? "unknown")
                    
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
        self.setupMarker()
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

struct GoogMapControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<GoogMapControllerRepresentable>) -> GoogleMapController {
        return GoogleMapController()
    }

    func updateUIViewController(_ uiViewController: GoogleMapController, context: UIViewControllerRepresentableContext<GoogMapControllerRepresentable>) {

    }
}

//struct MapView: View {
//    let apiClient = ApiClient()
//
//    var body: some View {
//        List{
//            Button(action: self.req) {
//                Text("REQ")
//            }
//            Button(action: self.geocoding){
//                Text("GeoCoding")
//            }
//        }.onAppear {
//            self.geocoding()
//        }
//    }
//
//
//
//    func req(){
//        let builder = ComponentBuilder()
//        let director = ExternalComponentDirector(builder: builder)
//
//        let url = director
//        .setHost(host: "")
//        .setPath(path: "")
//        .addQueryItem(name: "", value: "")
//        .addQueryItem(name: "", value: "")
//        .build()
//
//        //
//        apiClient.get(url: url)
//            .onSuccess{ data in
//
//            }
//        .onFailure { error in
//            print("\(error)")
//        }
//
//    }
//}
