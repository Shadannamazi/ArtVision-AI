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
        openai = OpenAI(Configuration(organizationId: "Personal", apiKey: apiKey ))
    }
    
    func aspectRatio(for size: String) -> CGFloat {
            switch size {
            case "square":
                return 1.0
            case "rectangle":
                return 4.0 / 3.0
            case "rectangle.portrait":
                return 3.0 / 4.0
            default:
                return 1.0
            }
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
    
    func getPrompt(style: String, size: String, description: String, colour: String, insertPrompt: String, imageStyle: [String: String]) -> String {
        if var prompt = imageStyle[style] {
            prompt = prompt.replacingOccurrences(of: "{insert_prompt}", with: insertPrompt)
            prompt = prompt.replacingOccurrences(of: "{insert_size}", with: size)
            prompt = prompt.replacingOccurrences(of: "{insert_background_des}", with: description)
            prompt = prompt.replacingOccurrences(of: "{insert_background_colour}", with: colour)
            return prompt
        }
        return ""
    }

    
    
//    func getSize(style: String, size: String, imageStyle: [String: String]) -> String {
//
//            if let prompt = imageStyle[style] {
//                return prompt.replacingOccurrences(of: "{insert_size}", with: size)
//            }
//            return ""
//    }

    
    
}

struct ImageGenerator: View {
    
    
    
    @ObservedObject var viewModel = ViewModel()
    @EnvironmentObject var cameraController : CameraController
    @EnvironmentObject var profileManager: ProfileManager
    
    @State var text = ""
    @State var image: UIImage?
    
    @State private var selectedSize = "square"
    
    @State private var selectedStyle = "Cartoon"
    @State var backgroundColour = ""
    @State var backgroundDescription = ""
    @State var outputPictureTitle = ""
    
    @FocusState private var textIsFocused: Bool
    @FocusState private var textImageTitleIsFocused: Bool
    
    
    @State var imageOutput: ImageOutput?
    
    //let imageStyle = ["Cartoon", "Realistic", "3D", "Pastel", "Anime"]
    let imageSizes = ["square", "rectangle", "rectangle.portrait"]
    let imageLabels = ["Square", "Rectangle 4:3", "Rectangle 3:4"]
    
    let imageStyle = [
                    "Cartoon": "A {insert_size} size cartoon-style illustration of a {insert_prompt}, graduation album cover color palette, inspired by the styles of Martine Johanna, Simon Stålenhag, Chie Yoshii, Casey Weldon, and WLOP. The artwork features ornate and dynamic elements, particulate details, rich and vibrant colors, intricate designs, and an elegant overall composition. Rendered in smooth and sharp focus, with an 8K resolution, utilizing Octane render with a background of {insert_background_des} with {insert_background_colour} background color.",
                    
                       "Realistic": "A {insert_size} size photorealistic painting of a {insert_prompt}, muscle extremely detailed, face full of emotion, trending on Artstation, Pixiv, CGSociety, hyperdetailed Unreal Engine rendering, optimized for 4K and 8K ultra HD, reminiscent of WLOP's artworks with a background of {insert_background_des} with {insert_background_colour} background color.",
                       
                       "3D": "An {insert_size} size intricately detailed 3D model of a {insert_prompt}, with a realistic and moody lighting reminiscent of Blade Runner, created using cinematic techniques. The scene is inspired by the works of Denis Villeneuve, Craig Mullins, and Ridley Scott. The 3D rendering is done using Octane, providing photorealistic visuals and optimized for high resolutions with a background of {insert_background_des} with {insert_background_colour} background color.",
                      
                       "Pastel": "A {insert_size} size pastel-style digital painting of a {insert_prompt}, featuring a depressed mood and inspired by the artistic styles of Artgerm, Gerald Brom, Atey Ghailan, and Mike Mignola. The artwork showcases vibrant colors, hard shadows, strong rim light, and a plain background, resembling the cover art of a comic book. The piece is currently trending on Artstation with a background of {insert_background_des} with {insert_background_colour} background color.",
                      
                       "Anime":"A {insert_size} size soft studio-lit anime-style illustration of a {insert_prompt}, delicately detailed with intricate features. The artwork is inspired by the works of Greg Rutkowski, Makoto Shinkai, Takashi Takeuchi, and Studio Ghibli. The illustration is currently trending on Pixiv Fanbox with a background of {insert_background_des} with {insert_background_colour} background color."]
    
    @State var on = true
    
    var body: some View {
        NavigationView{
            VStack{
                if let image = image {
                    
                    
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(viewModel.aspectRatio(for: selectedSize), contentMode: .fit)
                        .frame(width: 300, height: 300 * viewModel.aspectRatio(for: selectedSize))
                    TextField("Title:", text: $outputPictureTitle)
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(30)
                    Button{
                        imageOutput = ImageOutput(
                            name: "Generated Image",
                            backgroundColor: backgroundColour,
                            backgroundDescription: backgroundDescription,
                            size: selectedSize,
                            classificationLabel: cameraController.classificationLabel,
                            image: image
                        )
                        profileManager.addToProfile(image: imageOutput!)
                        
                    }label: {
                        Text("Save Project")
                            
                    }
                    
                    
                }else{
                    //Text(cameraController.classificationLabel)
                    Form{
                        Section(header: Text("Image Description")){
                            Picker("Style", selection: $selectedStyle) {
                                
                                ForEach(Array(imageStyle.keys), id: \.self) { style in
                                                           Text(style).tag(style)
                                                       }
                                                   }
                                            Toggle("Add Background ", isOn: $on)
                            if on{
                                TextField("Colour:", text: $backgroundColour,axis: .vertical)
                                    .focused($textIsFocused)
                                TextField("Descrption:", text: $backgroundDescription,axis: .vertical)
                                    .focused($textIsFocused)
                                
                                Button("Submit") {
                                        textIsFocused = false
                                }
                            }
                            
                        }
                        
                        
                        Picker("Image Dimension", selection: $selectedSize) {
                            ForEach(imageSizes, id: \.self) { size in
                                ImageDimensionView(size: size, imageSizes: imageSizes, imageLabels: imageLabels)
                                        }
                        }
                        .pickerStyle(.inline)
                        

                        
                    }
                    .frame(alignment: .top)
                    .scrollContentBackground(.hidden)
                    .frame(height: 475, alignment: .top)
                    
                    Button("Generate!"){
                        
                        Task{
                            let result = await viewModel.generateImage(
                                prompt: viewModel.getPrompt(
                                    style: selectedStyle,
                                    size: selectedSize,
                                    description: backgroundDescription,
                                    colour: backgroundColour,
                                    insertPrompt: cameraController.classificationLabel,
                                    imageStyle: imageStyle))
                            
                            
                            if result == nil {
                                        print("failed to get image")
                            } else {
                                print("Generated Image")
                                self.image = result
                                        
                                        
                        }

                        }
                        
                    }
                    .foregroundColor(Color.white)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .padding(.vertical,20)
                    .padding(.horizontal, 135)
                    .background(Color.black)
                .clipShape(Capsule())
                    
           
                }
                
            }
            
        }
        .navigationTitle("Image Generator")
        .onAppear{
            viewModel.setUp()
                
        }
        .environmentObject(ProfileManager())
       
        
  
    }
        
}

struct ImageDimensionView: View {
    var size: String
    var imageSizes: [String]
    var imageLabels: [String]

    var body: some View {
        if let index = imageSizes.firstIndex(of: size) {
            Label {
                Text(imageLabels[index])
            } icon: {
                Image(systemName: size)
                    .frame(width: 30, height: 30)
                    .foregroundColor(.black)
            }
        }
    }
}

struct ImageGenerator_Previews: PreviewProvider {
    static var previews: some View {
        ImageGenerator()
            .environmentObject(CameraController())
            .environmentObject(ProfileManager())
    }
}
