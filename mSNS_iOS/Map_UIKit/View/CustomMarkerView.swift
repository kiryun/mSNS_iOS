//
//  CustomMarkerView.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/04/23.
//  Copyright © 2020 wimes. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

//class MarkerImageView: UIView{
//    var img: UIImage!
//    var borderColor: UIColor!
//
//    init(frame: CGRect, image: UIImage, borderColor: UIColor, tag: Int) {
//        super.init(frame: frame)
//        self.img = image
//        self.borderColor = borderColor
//        self.tag = tag
//        self.setupViews()
//    }
//
//    func setupViews(){
//        let imgView = UIImageView(image: self.img)
//        imgView.frame=CGRect(x: 0, y: 0, width: 50, height: 50)
//        imgView.layer.cornerRadius = 25
//        imgView.layer.borderColor=self.borderColor?.cgColor
//        imgView.layer.borderWidth=4
//        imgView.clipsToBounds=true
//        let lbl=UILabel(frame: CGRect(x: 0, y: 45, width: 50, height: 10))
//        lbl.text = "▾"
//        lbl.font=UIFont.systemFont(ofSize: 24)
//        lbl.textColor = self.borderColor
//        lbl.textAlignment = .center
//
//        self.addSubview(imgView)
//        self.addSubview(lbl)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}

class CustomMarkerView: GMSMarker{
    var background: UIImage = UIImage(named: "marker")!.withRenderingMode(.alwaysTemplate)
    var heartIcon: UIImage = UIImage(named: "empty_heart")!.withRenderingMode(.alwaysTemplate)
    let thumnail: UIImage = UIImage()
    let textView: UITextView = UITextView()
    
    override init(){
        super.init()

        self.resizingImages()
        
        
        let markerView = UIImageView(image: self.background)
        let heartView = UIImageView(image: self.heartIcon)
        let thumnailView = UIImageView(image: self.thumnail)
        
        markerView.addSubview(heartView)
        markerView.addSubview(thumnailView)
        markerView.addSubview(self.textView)
        // set postion
        
        // marker building
        self.iconView = markerView
    }
    
    func resizingImages(){
        
        self.background = self.background.resizeImage(targetSize: CGSize(width: 48, height: 128))
        self.heartIcon = self.heartIcon.resizeImage(targetSize: CGSize(width: 12, height: 12))
    }
    
    func setPosition(){
        
    }
}
