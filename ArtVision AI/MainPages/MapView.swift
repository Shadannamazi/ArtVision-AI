//
//  MapView.swift
//  ParkMate
//
//  Created by Shadan Namazi on 2023-06-25.
//

import SwiftUI
import MapKit

struct MapView: View {
   
    @EnvironmentObject var profileManager: ProfileManager
    @StateObject var locationManager = LocationManager()
    
        
    
    var body: some View {
        ZStack {
//            Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
            Map(coordinateRegion: $locationManager.region, showsUserLocation: true, annotationItems: profileManager.artGalleries, annotationContent: { gallery in
                MapMarker(coordinate: CLLocationCoordinate2D(latitude: 49.3374451, longitude: -123.1442213),tint: .blue)
            })
                .edgesIgnoringSafeArea(.all)
                .onAppear{
                    locationManager.checkLocEnabled()
                        
            }
            Spacer()
            ForEach(profileManager.artGalleries, id: \.id) { gallery in
                Spacer()
                GalleryCard(artGallery: gallery)
            }
//            ZStack {
//
//                ForEach(profileManager.artGalleries, id: \.id) { gallery in
//                    Spacer()
//                    GalleryCard(artGallery: gallery)
//                        //.shadow(radius: Color.black.opacity(0.3))
//                        //.padding()
//
//
//                }
//            }
           
        }
            
    }
        
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(LocationManager())
            .environmentObject(ProfileManager())
        
    }
}
