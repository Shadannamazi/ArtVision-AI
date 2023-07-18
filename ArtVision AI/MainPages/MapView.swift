//
//  MapView.swift
//  ParkMate
//
//  Created by Shadan Namazi on 2023-06-25.
//

import SwiftUI
import MapKit

struct MapView: View {
   
    //@EnvironmentObject var locationManager: LocationManager
    @StateObject var locationManager = LocationManager()
    
        
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
                .edgesIgnoringSafeArea(.all)
                .onAppear{
                    locationManager.checkLocEnabled()
                        
            }
           
        }
            
    }
        
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(LocationManager())
        
    }
}
