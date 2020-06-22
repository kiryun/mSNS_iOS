//
//  SignInView.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/06/20.
//  Copyright © 2020 wimes. All rights reserved.
//

import SwiftUI

struct SignInView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<SignInView>) -> SignInViewController {
        return SignInViewController()
    }
    
    func updateUIViewController(_ uiViewController: SignInViewController, context: UIViewControllerRepresentableContext<SignInView>) {
        
    }
}

