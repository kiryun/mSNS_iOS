//
//  ContentView.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/04/12.
//  Copyright © 2020 wimes. All rights reserved.
//

import SwiftUI


struct MapView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<MapView>) -> MapViewController {
        return MapViewController()
    }

    func updateUIViewController(_ uiViewController: MapViewController, context: UIViewControllerRepresentableContext<MapView>) {

    }
}
