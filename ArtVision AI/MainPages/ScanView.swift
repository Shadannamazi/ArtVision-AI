//
//  ScanView.swift
//  ParkMate
//
//  Created by Shadan Namazi on 2023-06-25.
//

import SwiftUI

struct ScanView: View {
    @StateObject var cameraController = CameraController()
    @State private var isActive = false

    var body: some View {
        NavigationView {
            ZStack {
                CameraPreview(camera: cameraController)
                    .ignoresSafeArea(.all, edges: .all)

                VStack {
                    if cameraController.isTaken{
                        
                        HStack {
                            Button{
                                    cameraController.retakePic()
                                } label: {
                                    Image(systemName: "xmark")
                                        .foregroundColor(Color.black)
                                }
                                
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                                .padding(.vertical,10)
                                .padding(.horizontal, 20)
                                .background(Color.white)
                            .clipShape(Circle())
                            
                        }
                        
                            
                        
                    }
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    //HStack {
                        
                        if cameraController.isTaken{
                            HStack {
//                                Button{
//                                    cameraController.retakePic()
//                                } label: {
//                                    Image(systemName: "xmark")
//                                        .foregroundColor(Color.white)
//                                }
                                if !cameraController.isGenerated{
                                    Button{
                                        if !cameraController.isGenerated{
                                            cameraController.generateImage()
                                            
                                            
                                        } else{
                                            
                                        }
                                    } label: {

                                        //Text(cameraController.classificationLabel)
                                        Image(systemName: "checkmark")
                                            .foregroundColor(Color.black)
                
                                        
                                    }
                                    .foregroundColor(.black)
                                    .fontWeight(.semibold)
                                    .padding(.vertical,20)
                                    .padding(.horizontal, 40)
                                    .background(Color.white)
                                .clipShape(Circle())
                                }
                                
                                
                                NavigationLink{
                                    
                                    ImageGenerator()
                                        .environmentObject(cameraController)
                                } label:{
                                    if cameraController.isGenerated{
                                        Image(systemName: "arrow.right")
                                            .foregroundColor(Color.black)
                                            .foregroundColor(.black)
                                            .fontWeight(.semibold)
                                            .padding(.vertical,20)
                                            .padding(.horizontal, 40)
                                            .background(Color.white)
                                        .clipShape(Circle())
                                    }
                                    
                                   
                                }
                                
                            }
                            //Spacer()
                        } else{
                            Button(action: cameraController.takePic, label: {
                                ZStack {
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 65, height: 65)

                                    Circle()
                                        .stroke(Color.white, lineWidth: 2)
                                        .frame(width: 75, height: 75)
                                    
                                    
                                }
                            })
                        }
                    //}

                    Spacer()
                }
            }
            .onAppear {
                #if !targetEnvironment(simulator)
                cameraController.checkIfCameraAuthorized()
                #endif
        }
        }
    }
}


struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}


