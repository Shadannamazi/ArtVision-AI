//
//  ImageGenerator.swift
//  ParkMate
//
//  Created by Shadan Namazi on 2023-07-16.
//

import SwiftUI
import OpenAIKit

final class ViewModel: ObservableObject{
    
    private var openai: OpenAI?
    func setUp(){
        openai = OpenAI(Configuration(organizationId: "Personal", apiKey: ""))
    }
    
    func generateImage(prompt: String) async -> UIImage? {
        
        guard let openai = openai else{
            return nil
        }
        
        do{
            let params = ImageParameters(prompt: prompt, resolution: .medium, responseFormat: .base64Json)
            
            let result = try await openai.createImage(parameters: params)
            
            let data = result.data[0].image //this is a string
            
            let image = try openai.decodeBase64Image(data)
            
            return image
        }catch{
            print(String(describing: error))
            return nil
        }
    }
}

struct ImageGenerator: View {
    
    @ObservedObject var viewModel = ViewModel()
    @EnvironmentObject var cameraController : CameraController
    @State var text = ""
    @State var image: UIImage?
    
    var body: some View {
        NavigationView{
            VStack{
                if let image = image {
                    
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                }else{
                    //Text(cameraController.classificationLabel)
                    Text("Type prompt to generate image!")
                }
                
                //Text(cameraController.classificationLabel)
                
                Button("Generate!"){
                   
                    Task{
                        let result = await viewModel.generateImage(prompt: cameraController.classificationLabel)
                        
                        
                        if result == nil{
                            print("failed to get image")
                        }
                        self.image = result
                    }
                }
            }
        }
        .navigationTitle("Image Generator")
        .onAppear{
            viewModel.setUp()
        }
        .padding()
    }
}

struct ImageGenerator_Previews: PreviewProvider {
    static var previews: some View {
        ImageGenerator()
            .environmentObject(CameraController())
    }
}
