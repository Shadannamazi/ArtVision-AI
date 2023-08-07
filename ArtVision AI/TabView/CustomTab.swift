//
//  CustomTab.swift
//  ParkMate
//
//  Created by Shadan Namazi on 2023-06-25.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case map
    case viewfinder
    case person
}

struct CustomTab: View {
    @Binding var selectedTab: Tab
    
    
    var body: some View {
        VStack{
            HStack{
                ForEach(Tab.allCases, id: \.rawValue) {tab in
                    Spacer()
                    Image(systemName: tab.rawValue)
                        .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
                        .font(.system(size: 20))
                        .foregroundColor(selectedTab == tab ? .black : .gray)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                    
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .frame(width: nil,height: 60)
            .background(.thinMaterial)
            .cornerRadius(10)
            .padding()
        }
    
        
    }
}

struct CustomTab_Previews: PreviewProvider {
    static var previews: some View {
        CustomTab(selectedTab: .constant(.viewfinder))
    }
}
