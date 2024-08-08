//
//  MainTabView.swift
//  MotaNet
//
//  Created by sam hastings on 08/08/2024.
//

import SwiftUI

struct MainTabView: View {
    let user: User
    @State private var selectedIndex = 0
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            Text("Feed View")
                .onAppear{
                    selectedIndex = 0
                }
                .tabItem {
                    Image(systemName: "house")
                }.tag(0)
            Text("Search View")
                .onAppear{
                    selectedIndex = 1
                }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }.tag(1)
            Text("WorkoutLibraryView")
                .onAppear{
                    selectedIndex = 2
                }
                .tabItem {
                    Image(systemName: "dumbbell")
                }.tag(2)
            Text("CalendarView")
                .onAppear{
                    selectedIndex = 3
                }
                .tabItem {
                    Image(systemName: "calendar")
                }.tag(3)
            Text("CurrentUserProfileView")
                .onAppear{
                    selectedIndex = 4
                }
                .tabItem {
                    Image(systemName: "person")
                }.tag(4)
        }
        .tint(.black)
    }
}


#Preview {
    MainTabView(user: User.MOCK_USERS[0])
}
