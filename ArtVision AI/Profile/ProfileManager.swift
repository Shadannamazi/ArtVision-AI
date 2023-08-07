//
//  ProfileManager.swift
//  ArtVision AI
//
//  Created by Shadan Namazi on 2023-08-02.
//

import SwiftUI

class ProfileManager: ObservableObject {

    
    @Published private(set) var images: [ImageOutput] = []
    @Published private(set) var imageNameList: [String] = []
    @Published private(set) var total: Int = 0
    
    func addToProfile(image: ImageOutput) {
        images.append(image)
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

