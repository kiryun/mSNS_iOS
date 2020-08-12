//
//  CameraView.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/08/12.
//  Copyright © 2020 wimes. All rights reserved.
//

import SwiftUI

struct CameraView: View {
    @Binding var image: UIImage?
    @State var didTapCapture: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            CameraRepresentable(image: self.$image, didTapCapture: self.$didTapCapture)
            CaptureButtonView().onTapGesture {
                self.didTapCapture = true
            }
        }
    }
}

struct CaptureButtonView: View {
    @State private var animationAmount: CGFloat = 1
    var body: some View {
        Image(systemName: "video").font(.largeTitle)
            .padding(30)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.red)
                    .scaleEffect(animationAmount)
                    .opacity(Double(2 - animationAmount))
                    .animation(Animation.easeOut(duration: 1)
                        .repeatForever(autoreverses: false))
        )
            .onAppear
            {
                self.animationAmount = 2
        }
    }
}
