//
//  ViewController.swift
//  ParkMate
//
//  Created by Shadan Namazi on 2023-06-27.
//

import SwiftUI
import AVFoundation
import UIKit


class CameraController: NSObject, ObservableObject {
    @Published var isTaken = false
    @Published var session = AVCaptureSession()
    @Published var alert = false
    @Published var output = AVCapturePhotoOutput()
    @Published var preview: AVCaptureVideoPreviewLayer!
    
    func checkIfCameraAuthorized() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] status in
                if status {
                    self?.setUp()
                }
            }
        case .denied:
            self.alert.toggle()
        case .authorized:
            setUp()
        case .restricted:
            return
        @unknown default:
            return
        }
    }
    
    func setUp() {
        // Setting up the camera
        do {
            self.session.beginConfiguration()
            guard let device = AVCaptureDevice.default(for: .video) else { return }
            let input = try AVCaptureDeviceInput(device: device)
            
            if self.session.canAddInput(input) {
                self.session.addInput(input)
            }
            
            if self.session.canAddOutput(self.output) {
                self.session.addOutput(self.output)
            }
            
            self.session.commitConfiguration()
            self.session.startRunning()
        } catch {
            print(error.localizedDescription)
        }
    }
}


struct CameraPreview: UIViewRepresentable{
    
    @ObservedObject var camera: CameraController
    
    func makeUIView(context: Context) ->  UIView {
            let view = UIView(frame: UIScreen.main.bounds)
            
            camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
            camera.preview.frame = view.frame
            
            camera.preview.videoGravity = .resizeAspectFill
            view.layer.addSublayer(camera.preview)
            return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
       
    }
    
}
