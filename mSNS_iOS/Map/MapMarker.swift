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

class MapMarker{
    var buildMarker: GMSMarker = GMSMarker()
    var marker: GMSMarker{
        get{
            return self.buildMarker
        }
    }
    
    struct Background{
        
    }
    
    struct HeartIcon{
        
    }
    
    struct Text{
        
    }
}
