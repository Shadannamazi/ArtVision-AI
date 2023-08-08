//
//  LocationAnnotationView.swift
//  ArtVision AI
//
//  Created by Shadan Namazi on 2023-08-07.
//

import SwiftUI

struct LocationAnnotationView: View {
    var body: some View {
        VStack(spacing: 0){
            Image(systemName: "photo.artframe")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .font(.headline)
                .foregroundColor(.accentColor)
                
        }
    }
}

struct LocationAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationAnnotationView()
    }
}
