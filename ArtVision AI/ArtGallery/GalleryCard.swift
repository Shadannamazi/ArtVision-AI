//
//  GalleryCard.swift
//  ArtVision AI
//
//  Created by Shadan Namazi on 2023-08-07.
//

import SwiftUI
import CoreLocation
import MapKit


struct GalleryCard: View {
    
    var artGallery: ArtGallery
    
    var body: some View {
        
        VStack {
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
 
           
            
            HStack(alignment: .bottom, spacing: 0){
                
                VStack(alignment: .leading, spacing: 16){
                    
                    imageSection
                    titleSection
                    
                }
                
                VStack{
                    
                  
                    //viewGalleryButton
                    
                    NavigationLink{
                        ArtGalleryView(artGallery: artGallery)
                    }label: {
                        ZStack{
                            Rectangle()
                                .foregroundColor(.blue)
                                .cornerRadius(10)
                                .frame(width: 150, height: 50)
                            Text("View Gallery")
                                .font(.headline)
                                .foregroundColor(Color.white)
                                .frame(width: 125, height: 35)
                        }
                        
                           
                          
                            
                    }
                    .frame(height: 100)
                    .listRowBackground(Color.blue)
                    
                    //viewGalleryButton
                    
                }
                
            }
            .padding(20)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y:65)
            )
        .cornerRadius(10)
            Spacer()
        }
       
    }
}

struct GalleryCard_Previews: PreviewProvider {
    static var previews: some View {
        
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
        let placeHolderGallery = ArtGallery(name: "My Art Gallery", imageCover: placeholderImageOutput, author: "Shadan", coordinates: MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 40.83834587046632,
                longitude: 14.254053016537693
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.03,
                longitudeDelta: 0.03
            )
        )
, description: "This is an Art Gallery")
        GalleryCard(artGallery: placeHolderGallery)
            .padding()
    }
}

extension GalleryCard {
    private var imageSection: some View{
        ZStack{
            Image(uiImage: artGallery.imageCover.image)
                .resizable()
                .scaledToFit()
                .frame(width:100, height: 100)
                .cornerRadius(10)
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private var titleSection: some View{
        VStack(alignment: .leading, spacing: 4){
            Text(artGallery.name)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(artGallery.author)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var viewGalleryButton: some View{
        Button{
            
        }label: {
            Text("View Gallery")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.borderedProminent)

    }
}




