//
//  ProfilView.swift
//  Instagram Clone
//
//  Created by Burak Cüce on 27.06.22.
//

import SwiftUI

struct ProfileProjectView: View {
    @EnvironmentObject var profileManager: ProfileManager
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())]
    

    
    let imageDimension = UIScreen.main.bounds.width / 3
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        
                        Text("Shadannamazi")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                        
                        Spacer()
                        
                        Button{
                            
                        }label: {
                            Image(systemName: "plus.app")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color.black)
                                .padding()
                        }
                        
                        Button{
                            
                        }label: {
                            Image(systemName: "list.bullet")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color.black)
                                .padding(5)
                        }
                        

                        
                        
                    }
                    
                    HStack {
                        Image("profilepic")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 84, height: 90)
                            .clipShape(Circle())
                        
                        Spacer()
                        
                        HStack(spacing: 27) {
                            
                            Spacer()
                          
                            
                            VStack(spacing: 2) {
                                Text(profileManager.getTotalNumProjects())
                                    .font(.subheadline)
                                    .foregroundColor(Color.black)
                                    .fontWeight(.semibold)
                                
                                Text("Projects")
                                    .font(.caption)
                                    .foregroundColor(Color.black)
                            }
                            
                            VStack(spacing: 2) {
                                Text("30")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.black)

                                
                                Text("Followers")
                                    .font(.caption)
                                    .foregroundColor(Color.black)

                            }
                            
                            VStack(spacing: 2) {
                                Text("25")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.black)

                                
                                Text("Following")
                                    .font(.caption)
                                    .foregroundColor(Color.black)

                            }
                            
                            Spacer()
                        }
                        
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Shadan Namazifard")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.black)

                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 4)
                    
                    HStack {
                        Button{
                            
                        }label: {
                            Text("Edit Profile")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.black)
                                .frame(width: 330, height: 34)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color(.systemGray3))
                                )
                        }
                        
                        Button{
                            
                        }label: {
                            Image(systemName: "person.badge.plus")
                                .font(.footnote)
                                .frame(width: 32, height: 34)
                                .foregroundColor(Color.black)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color(.systemGray3))
                                )
                        }
                        
                    }
                    
                    HStack {
                        Spacer()
                        Image(systemName: "squareshape.split.3x3")
                            .font(.title)
                        
                        Spacer()
                        
                        Image(systemName: "person.crop.square")
                            .font(.title)
                        
                        Spacer()
                        
                    }
                    .foregroundColor(Color(.darkGray))
                    .padding(.vertical, 6)
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        
                        ForEach(profileManager.images, id: \.id) { image in
                            
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
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

struct ProfileProjectView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileProjectView()
            .environmentObject(ProfileManager())
    }
}
