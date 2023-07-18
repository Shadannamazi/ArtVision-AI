//
//  ViewController.swift
//  ParkMate
//
//  Created by Shadan Namazi on 2023-06-27.
//

import SwiftUI
import AVFoundation
import UIKit





class CameraController: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    @Published var isTaken = false
    @Published var session = AVCaptureSession()
    @Published var output = AVCapturePhotoOutput()
    @Published var preview: AVCaptureVideoPreviewLayer!
    @Published var alert = false
    @Published var isSaved = false
    @Published var isGenerated = false
    @Published var picData = Data(count: 0)
    //@Published var capturedImage: UIImage? = nil
    
    let model = SqueezeNet()
    @Published var classificationLabel: String = ""
    //@StateObject var cameraController = CameraController()
    
    func performImageClassification(image: UIImage){
        
//        guard let img = image,
//              let resizedImage = img.resizeImageTo(size: CGSize(width: 227, height: 227)),
//              let buffer = resizedImage.convertToBuffer() else{
//            return
//        }
       
        let resizedImage = image.resizeImageTo(size: CGSize(width: 227, height: 227))!
        let buffer = resizedImage.convertToBuffer()!
        
        let prediction = try? model.prediction(image: buffer)

        
        if let prediction = prediction {
            self.classificationLabel = prediction.classLabel
        }
    }

    
    func checkIfCameraAuthorized() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] status in
                DispatchQueue.main.async {
                    if status {
                        self?.setUp()
                    } else {
                        self?.alert = true
                    }
                }
            }
        case .denied:
            self.alert = true
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
    
    func takePic(){
        DispatchQueue.global(qos: .background).async {
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            
            
            DispatchQueue.main.async {
                withAnimation{
                    self.isTaken.toggle()
                }
            }
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.session.stopRunning()
        }
        
//        self.session.stopRunning()
    }
    
    func retakePic(){
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
        }
        
        DispatchQueue.main.async {
            withAnimation{
                self.isTaken.toggle()
                self.isSaved = false
                self.isGenerated = false
            }
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if error != nil{
            return
        }
        print("pic taken...")
        
        guard let imageData = photo.fileDataRepresentation() else{
            return
        }
        self.picData = imageData
    }
    
    func savePic(){
        let image = UIImage(data: self.picData)!
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        self.isSaved = true
        //performImageClassification(image: image)
        //print(classificationLabel)
    }
    
    func generateImage(){
        let image = UIImage(data: self.picData)!
        
        self.isGenerated = true
        performImageClassification(image: image)
        print(classificationLabel)
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


