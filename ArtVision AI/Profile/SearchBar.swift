//
//  SearchBar.swift
//  ArtVision AI
//
//  Created by Shadan Namazi on 2023-08-02.
//

import SwiftUI

struct SearchBar: View {
    @EnvironmentObject var profileManager: ProfileManager
    @State var searchText = ""
    @State var imagesList: [ImageOutput] = []
    @State var imagesListNames: [String] = []
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    
    var body: some View {
        NavigationView {
            
                
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(images, id: \.id) { image in
                                ImageCard(image: image)
                                    .environmentObject(profileManager)
                            
                        }
                    }
                    .padding()
                
                .searchable(text: $searchText)
            .navigationTitle("Projects")
            }
        }
        
    }
    
    
    
    var images: [ImageOutput] {
        if profileManager.images.count > 0 {
        
        
            }
        return searchText == "" ? imagesList : imagesList.filter{
            $0.name.lowercased().contains(searchText.lowercased())
        }
    
    }
    
    struct SearchBar_Previews: PreviewProvider {
        static var previews: some View {
            SearchBar()
                .environmentObject(ProfileManager())
        }
    }
}

