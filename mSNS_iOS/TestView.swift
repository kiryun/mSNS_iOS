//
//  ContentView.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/04/12.
//  Copyright © 2020 wimes. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let apiClient = ApiClient()
    
    var body: some View {
        Button(action: self.req) {
            Text("REQ")
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
