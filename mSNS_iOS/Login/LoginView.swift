//
//  LoginView.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/06/20.
//  Copyright © 2020 wimes. All rights reserved.
//

import SwiftUI

struct LoginView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<LoginView>) -> LoginViewController {
        return LoginViewController()
    }
    
    func updateUIViewController(_ uiViewController: LoginViewController, context: UIViewControllerRepresentableContext<LoginView>) {
        
    }
}

