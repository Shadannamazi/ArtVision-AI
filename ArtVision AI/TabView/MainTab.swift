//
//  MainTab.swift
//  ParkMate
//
//  Created by Shadan Namazi on 2023-06-25.
//

import SwiftUI

struct MainTab: View {
    @EnvironmentObject var profileManager: ProfileManager

    
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    @State var selectedTab: Tab = .viewfinder
    var body: some View {
        
        ZStack {
            VStack {
                TabView(selection: $selectedTab){
                    if selectedTab == .map {
                        MapView()
                    }
                    if selectedTab == .viewfinder {
                        ScanView()
                            .environmentObject(profileManager)
                            
                        //ContentView()
                    }
                    if selectedTab == .person {
                        ProfileProjectView()
                            .environmentObject(profileManager)
                    }
                    
                }
                
                
            }
            VStack{
                Spacer()
                CustomTab(selectedTab: $selectedTab)
                    .ignoresSafeArea(.keyboard)
                    .padding(.bottom,0)
                    
            }
            .ignoresSafeArea(.keyboard)
            
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
}

struct MainTab_Previews: PreviewProvider {
    static var previews: some View {
        MainTab()
            .environmentObject(ProfileManager())
      
    }
}
