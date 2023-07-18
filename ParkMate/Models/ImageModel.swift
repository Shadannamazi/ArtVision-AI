////
////  MLView.swift
////  ParkMate
////
////  Created by Shadan Namazi on 2023-07-12.
////
//
//import SwiftUI
//import CoreML
//
//class ImageModel:  NSObject, ObservableObject {
//    //let config = MLModelConfiguration()
//    //let model = try? SqueezeNet(configuration: config)
//    let model = SqueezeNet()
//    @Published var classificationLabel: String = ""
//    //@StateObject var cameraController = CameraController()
//    
//    func performImageClassification(){
//        guard let img = cameraController.capturedImage,
//              let resizedImage = img.resizeImageTo(size: CGSize(width: 227, height: 227)),
//              let buffer = resizedImage.convertToBuffer() else{
//            return
//        }
//        
//        let prediction = try? model.prediction(image: buffer)
//
//        
//        if let prediction = prediction {
//            self.classificationLabel = prediction.classLabel
//        }
//    }
//    
//    
//    
//}
//
//
