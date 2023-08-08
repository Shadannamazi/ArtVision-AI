//
//  ArtGallery.swift
//  ArtVision AI
//
//  Created by Shadan Namazi on 2023-08-07.
//

import SwiftUI
import Foundation
import MapKit

struct ArtGallery: Identifiable, Equatable {
    
    
    //let id = UUID().uuidString
    let name: String
    let imageCover: ImageOutput
    //let listOfImages: [ImageOutput]
    let author: String
    let coordinates: MKCoordinateRegion
    let description: String
    
    var id: String{
        name + author
    }
    
    static func == (lhs: ArtGallery, rhs: ArtGallery) -> Bool {
        lhs.id == rhs.id
    }
}


