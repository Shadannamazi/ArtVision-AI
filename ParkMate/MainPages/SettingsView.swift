//
//  SettingsView.swift
//  ParkMate
//
//  Created by Shadan Namazi on 2023-06-25.
//

import SwiftUI

struct SettingsView: View {
    
    //@StateObject var imageModelManager = ImageModel()
    @ObservedObject var cameraController = CameraController()
    
    
    var body: some View {
        //Image("plant")
        //UIImage(named: "plant")
        //let image = UIImage(data: cameraController.picData)!
        
        //Image(uiImage: image)
//        if let capturedImage = cameraController.capturedImage {
//                            Image(uiImage: capturedImage)
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                        }
        //Image(uiImage: cameraController.$capturedImage)
        ZStack{
            VStack{
                Button{
                    cameraController.savePic()
//                    cameraController.performImageClassification()
                } label: {
                    Text("press me")
                }
                Text(cameraController.classificationLabel)
            }
            
        }
        
        
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
        
    }
}
