//
//  BottomTabBarData.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/08/04.
//  Copyright © 2020 wimes. All rights reserved.
//

import Foundation
import Combine

class BottomTabBarData: ObservableObject{
    let itemIndex: Int
    let objectWillChange = PassthroughSubject<BottomTabBarData, Never>()
    var previousItem: Int
    
    var isItemSelected: Bool = false
    
    var itemSelected: Int{
        didSet{
            if self.itemSelected == itemIndex{
                self.previousItem = oldValue
                self.itemSelected = oldValue
                self.isItemSelected = true
            }
            self.objectWillChange.send(self)
        }
    }
    
    func reset(){
        self.itemSelected = self.previousItem
        self.objectWillChange.send(self)
    }
    
    init(initialIndex: Int = 1, itemIndex: Int) {
        self.itemIndex = itemIndex
        self.itemSelected = initialIndex
        self.previousItem = initialIndex
    }
}
