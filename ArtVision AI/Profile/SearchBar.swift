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
                HStack{
                    Image(systemName: "house")
                        .resizable()
                        .aspectRatio(contentMode: ContentMode.fit)
                        .frame(width: 80, height: 80)
                        .padding(22)
                    Text("Username")
                        .font(.headline)
                        .fontWeight(.bold)
                }
                
                    //.offset(x:0, y:-20)
                LazyVGrid(columns: columns, spacing: 20) {
                    
                    ForEach(profileManager.images, id: \.id) { image in
                        ImageCard(image: image)
                            .environmentObject(profileManager)
                            .id(UUID())
                    }
                    }
                    .padding()
                
                .searchable(text: $searchText)
            .navigationTitle("Profile")
            .environmentObject(profileManager)
            }
            .environmentObject(profileManager)
        }
        .environmentObject(profileManager)
        
    }
        
    
    
    
//    var images: [ImageOutput] {
//        if profileManager.images.count > 0 {
//
//
//            }
//        return searchText == "" ? imagesList : imagesList.filter{
//            $0.name.lowercased().contains(searchText.lowercased())
//        }
//
//    }
    
    struct SearchBar_Previews: PreviewProvider {
        static var previews: some View {
            SearchBar()
                .environmentObject(ProfileManager())
        }
    }
}

