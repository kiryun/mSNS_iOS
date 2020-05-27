//
//  Marker.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/04/23.
//  Copyright © 2020 wimes. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class MapMarker: GMSMarker{
    let background: UIImage = UIImage(named: "bg_visit")!.withRenderingMode(.alwaysTemplate)
    let heartIcon: UIImage = UIImage(named: "btn_heart_on")!.withRenderingMode(.alwaysTemplate)
    let thumnail: UIImage = UIImage()
    let textView: UITextView = UITextView()
    
    override init(){
        super.init()

         // setup marker
        let markerView = UIImageView(image: self.background)

        markerView.addSubview(UIImageView(image: self.heartIcon))
        markerView.addSubview(UIImageView(image: self.thumnail))
        markerView.addSubview(textView)
        // marker building
        self.iconView = markerView
    }
}
