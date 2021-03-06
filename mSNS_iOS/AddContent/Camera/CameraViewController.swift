//
//  CameraViewController.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/08/12.
//  Copyright © 2020 wimes. All rights reserved.
//

import Foundation
import UIKit
import AVKit

class CameraViewController: UIViewController{
    var image: UIImage?
    
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    var photoOutput: AVCapturePhotoOutput?
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var delegate: AVCapturePhotoCaptureDelegate!
    
    // camera capture 버튼 눌렀을 때 호출되는 메서드 여기에 이미지 데이터 저장
    func didTapRecord(){
        let settings = AVCapturePhotoSettings()
        self.photoOutput?.capturePhoto(with: settings, delegate: self.delegate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    func setup(){
        self.setupCaptureSession()
        self.setupDevice()
        self.setupInputOutput()
        self.setupPreviewLayer()
        self.startRunningCaptureSession()
    }
}

extension CameraViewController{
    func setupCaptureSession(){
        
        self.captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    func setupDevice(){
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera],
                                                                      mediaType: AVMediaType.video,
                                                                      position: AVCaptureDevice.Position.unspecified)
        
        for device in deviceDiscoverySession.devices{
            switch device.position {
            case AVCaptureDevice.Position.front:
                self.frontCamera = device
            case AVCaptureDevice.Position.back:
                self.backCamera = device
            default:
                break
            }
        }
        
        self.currentCamera = self.backCamera
    }
    
    func setupInputOutput() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: self.currentCamera!)
            self.captureSession.addInput(captureDeviceInput)
            self.photoOutput = AVCapturePhotoOutput()
            self.photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            self.captureSession.addOutput(self.photoOutput!)

        } catch {
            print(error)
        }

    }
    
    func setupPreviewLayer()
    {
        self.cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        self.cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        self.cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(self.cameraPreviewLayer!, at: 0)

    }
    func startRunningCaptureSession(){
        self.captureSession.startRunning()
    }
}
