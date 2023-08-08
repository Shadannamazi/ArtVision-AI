//
//  ProfileManager.swift
//  ArtVision AI
//
//  Created by Shadan Namazi on 2023-08-02.
//

import SwiftUI
import CoreLocation
import MapKit


class ProfileManager: ObservableObject {
    @StateObject var locationManager = LocationManager()
    
    @Published private(set) var images: [ImageOutput] = []
    @Published private(set) var imageNameList: [String] = []
    @Published private(set) var total: Int = 0
    
    @Published private(set) var artGalleries: [ArtGallery] = []
    
    func addToProfile(image: ImageOutput) {
        images.append(image)
        
        let newArtGallery = ArtGallery(name: "My Art Gallery", imageCover: image,  author: "Shadan", coordinates:locationManager.region, description: "This is my first art gallery")
        
        artGalleries.append(newArtGallery)
        
        total += 1
        
    }
    
    func getTotalNumProjects() -> String{
        return String(total)
    }
    
    func removeFromeProfile(image: ImageOutput) {
        images = images.filter {$0.id != image.id}
        total -= 1
    }
    
    func addToListOfNames(image: ImageOutput) {
        imageNameList.append(image.name)
        
    }
    
    func removeFromListOfNames(image: ImageOutput) {
        imageNameList = imageNameList.filter {$0 != image.name}
        
        
    }
}

