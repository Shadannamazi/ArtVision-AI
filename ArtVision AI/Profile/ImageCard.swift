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
    let imageDimension = UIScreen.main.bounds.width / 3
    @State var isAdded : Bool = false
    
    
    var body: some View {
        ZStack(alignment: .topTrailing){
            ZStack(alignment: .bottom) {
                
                Image(uiImage: image.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageDimension, height: imageDimension)
                    .border(Color.white)
                    .clipped()
        
                
            }
            .frame(width: 180, height: 250)
            
            
           
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
                image: UIImage(systemName: "photo")!,
                // placeholder image
                style: "Cartoon"
            )

            ImageCard(image: placeholderImageOutput)
                .environmentObject(ProfileManager())
        }
}
