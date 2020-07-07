//
//  User.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/05/24.
//  Copyright © 2020 wimes. All rights reserved.
//

import Foundation

struct User{
    static var shared = User()
    var uID: Int?
    var displayName: String?
    var email: String?
    var provider: String?
    var locale: String?
}

