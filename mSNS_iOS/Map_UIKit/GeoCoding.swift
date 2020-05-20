//
//  GeoCoding.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/04/14.
//  Copyright © 2020 wimes. All rights reserved.
//

import Foundation
import CoreLocation

class Geocoding{
//    var lat: Double = 0.0
//    var lon: Double = 0.0
//    
//    init(lat: Double, lon: Double) {
//        self.lat = lat
//        self.lon = lon
//    }
    
    
    func geoCode(address: String, completion: @escaping (_ placemark: [CLPlacemark]?, _ error: Error?) -> Void){
        CLGeocoder().geocodeAddressString(address) { placemark, error in
            guard let placemark = placemark, error == nil else{
                completion(nil, error)
                return
            }
            completion(placemark, nil)
        }
    }
    
    // https://stackoverflow.com/questions/46869394/reverse-geocoding-in-swift-4
    func reverseGeocode(location: CLLocation, completion: @escaping (_ placemark: [CLPlacemark]?, _ error: Error?) -> Void)  {
        CLGeocoder().reverseGeocodeLocation(location) { placemark, error in
            guard let placemark = placemark, error == nil else {
                completion(nil, error)
                return
            }
            completion(placemark, nil)
        }
    }
    
    // https://greenchobo.tistory.com/8
//    func convertToAddressWith(coordinate: CLLocation) {
//        let geoCoder = CLGeocoder()
//        geoCoder.reverseGeocodeLocation(coordinate){ (placemarks, error) -> Void in
//            if error != nil{
//                print("\(error)")
//                return
//            }
//
//            guard let placemarks = placemarks else {
//                completion(nil, error)
//                return
//            }
//            ccompletion(placemarks, nil)
//        }
//    }
}
