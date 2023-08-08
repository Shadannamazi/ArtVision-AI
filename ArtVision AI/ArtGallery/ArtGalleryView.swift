//
//  ArtGalleryView.swift
//  ArtVision AI
//
//  Created by Shadan Namazi on 2023-08-07.
//

import SwiftUI
import CoreLocation
import MapKit

struct ArtGalleryView: View {
    @EnvironmentObject var profileManager: ProfileManager
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())]
    
    @State var searchText = ""
    var artGallery: ArtGallery
    //let image: ImageOutput
    
    var projects: [ImageOutput] {
        
        return searchText == "" ? profileManager.images : profileManager.images.filter{
            $0.name.lowercased().contains(searchText.lowercased())
        }

    }
    
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns: columns, spacing: 20) {
                    
                    ForEach(projects, id: \.id) { image in
                        
                        NavigationLink(
                                                    destination: ViewProject(image: image),
                                                    label: {
                                                        ImageCard(image: image)
                                                            .environmentObject(profileManager)
                                                            .id(UUID())
                                                    }
                                                )
                                                .buttonStyle(PlainButtonStyle())
                    }
                }

            }
            .navigationTitle(artGallery.name)
            .searchable(text: $searchText)
            //.navigationBarTitleDisplayMode(.inline)
        }
        //.navigationBarBackButtonHidden(true)
        
    }
}





struct ArtGalleryView_Previews: PreviewProvider {
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
        ArtGalleryView(artGallery: placeHolderGallery)
            .environmentObject(ProfileManager())
    }
}
