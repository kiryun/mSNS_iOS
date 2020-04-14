//
//  ContentView.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/04/12.
//  Copyright © 2020 wimes. All rights reserved.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    let apiClient = ApiClient()
    
    var body: some View {
        List{
            Button(action: self.req) {
                Text("REQ")
            }
            Button(action: self.geocoding){
                Text("GeoCoding")
            }
        }
    }

    func geocoding(){
        // 경기도 수원시 장안구 수성로364번길 3
        let location = CLLocation(latitude: 37.293418, longitude: 127.011916)
        let geo: Geocoding = Geocoding()
        geo.geocode(location: location) { placemark, error in
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
    
    func req(){
        let builder = ComponentBuilder()
        let director = ExternalComponentDirector(builder: builder)
        
        let url = director
        .setHost(host: "")
        .setPath(path: "")
        .addQueryItem(name: "", value: "")
        .addQueryItem(name: "", value: "")
        .build()
        
        //
        apiClient.get(url: url)
            .onSuccess{ data in
                
            }
        .onFailure { error in
            print("\(error)")
        }
    
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
