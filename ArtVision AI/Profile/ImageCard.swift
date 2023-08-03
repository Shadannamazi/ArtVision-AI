//
//  ImageCard.swift
//  ArtVision AI
//
//  Created by Shadan Namazi on 2023-07-31.
//

import SwiftUI

struct ImageCard: View {
    @EnvironmentObject var profileManager: ProfileManager
    var image: ImageOutput
    @State var isAdded : Bool = false
    var body: some View {
        ZStack(alignment: .topTrailing){
            ZStack(alignment: .bottom) {
                Image(uiImage: image.image)
                    .resizable()
                    //.cornerRadius(20)
                    .frame(width: 180)
                    .scaledToFit()
                VStack(alignment: .leading){
                    Text(image.name)
                        .bold()
                    
                }
                .padding()
                .frame(width: 180,alignment: .leading)
                .background(.ultraThinMaterial)
                
            }
            .frame(width: 180, height: 250)
            
            Button {
                self.isAdded.toggle()
                profileManager.addToProfile(image: image)
                
                
            } label: {
                Image(systemName: self.isAdded == true ? "plus.app.fill" : "plus.app")
                
            }
            .padding(10)
            .font(.system(size: 22))
        }
        
        
        
    }
}

struct ImageCard_Previews: PreviewProvider {
    static var previews: some View {
            // Create a placeholder ImageOutput for the preview
            let placeholderImageOutput = ImageOutput(
                name: "Placeholder Image",
                backgroundColor: "White",
                backgroundDescription: "Artistic Background",
                size: "square",
                classificationLabel: "Art",
                image: UIImage(systemName: "photo")! // placeholder image
            )

            ImageCard(image: placeholderImageOutput)
                .environmentObject(ProfileManager())
        }
}
