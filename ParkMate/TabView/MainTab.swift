//
//  MainTab.swift
//  ParkMate
//
//  Created by Shadan Namazi on 2023-06-25.
//

import SwiftUI

struct MainTab: View {
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    @State var selectedTab: Tab = .map
    var body: some View {
        
        ZStack {
            VStack {
                TabView(selection: $selectedTab){
                    if selectedTab == .map {
                        MapView()
                    }
                    if selectedTab == .viewfinder {
                        ScanView()
                    }
                    if selectedTab == .gear {
                        SettingsView()
                    }
                    
                }
              
                
            }
            VStack{
                Spacer()
                CustomTab(selectedTab: $selectedTab)
                    .padding(.bottom,0)
            }
            
        }
        
    }
}

struct MainTab_Previews: PreviewProvider {
    static var previews: some View {
        MainTab()
    }
}
