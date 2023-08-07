//
//  ViewProject.swift
//  ArtVision AI
//
//  Created by Shadan Namazi on 2023-08-06.
//

import SwiftUI

struct ViewProject: View {
    @EnvironmentObject var profileManager: ProfileManager
    let imageDimension = UIScreen.main.bounds.width
    
    var image: ImageOutput
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Image(uiImage: image.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: imageDimension, height: imageDimension)
                        .border(Color.white)
                        .clipped()
                    Text(image.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                        
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Classification Label: \(image.classificationLabel)")
                            .multilineTextAlignment(.leading) // Align text to the left
                        Text("Style: \(image.style)")
                            .multilineTextAlignment(.leading) // Align text to the left
                        Text("Background Colour: \(image.backgroundColor)")
                            .multilineTextAlignment(.leading) // Align text to the left
                        Text("Background Description: \(image.backgroundDescription)")
                            .multilineTextAlignment(.leading) // Align text to the left
                        Text("Image Dimension: \(image.size)")
                            .multilineTextAlignment(.leading) // Align text to the left
                       
                    }
                    .padding()
                    .frame(width: imageDimension)
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                  
                  
                    Spacer()
                }
                .navigationBarTitle("", displayMode: .inline)
            }
        }
    }
}

struct ViewProject_Previews: PreviewProvider {
    static var previews: some View {
        let placeholderImageOutput = ImageOutput(
            name: "Placeholder Image",
            backgroundColor: "White",
            backgroundDescription: "Artistic Background",
            size: "square",
            classificationLabel: "Art",
            image: UIImage(systemName: "photo")!, // placeholder image
            style: "Cartoon"
        )
        ViewProject(image: placeholderImageOutput)
            .environmentObject(ProfileManager())
    }
}



