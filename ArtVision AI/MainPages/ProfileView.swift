//
//  SettingsView.swift
//  ParkMate
//
//  Created by Shadan Namazi on 2023-06-25.
//

import SwiftUI

struct ProfileView: View {

    
    
    var body: some View {
        SearchBar()
        //Text("hello")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(ProfileManager())
        
    }
}
