//
//  MainTabView.swift
//  MotaNet
//
//  Created by sam hastings on 08/08/2024.
//

import SwiftUI
import SwiftData

struct MainTabView: View {
    let user: User
    @State private var selectedIndex = 0
    @Environment(\.modelContext) private var modelContext: ModelContext
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            FeedView()
                .onAppear{
                    selectedIndex = 0
                }
                .tabItem {
                    Image(systemName: "house")
                }.tag(0)
            SearchView()
                .onAppear{
                    selectedIndex = 1
                }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }.tag(1)
            WorkoutLibraryView(user: user)
                .onAppear{
                    selectedIndex = 2
                }
                .tabItem {
                    Image(systemName: "dumbbell")
                }.tag(2)
            CalendarView(user: user)
                .onAppear{
                    selectedIndex = 3
                }
                .tabItem {
                    Image(systemName: "calendar")
                }.tag(3)
            ProfileView(user: user)
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
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: false)
        let container = try ModelContainer(
            for: Exercise.self,
            configurations: config
        )
        let descriptor = FetchDescriptor<Exercise>()
        let existingExercises = try container.mainContext.fetch(descriptor)
        guard existingExercises.isEmpty else {
            print("Exercises already exist")
            return MainTabView(user: User.MOCK_USERS[0])
                .modelContainer(container)
        }
        guard let url = Bundle.main.url(forResource: "exercises", withExtension: "json") else {
            fatalError("Failed to find exercises.json")
        }
        let data = try Data(contentsOf: url)
        let exercises = try JSONDecoder().decode([Exercise].self, from: data)
        for exercise in exercises {
            container.mainContext.insert(exercise)
        }
        print("Exercises created")
        
        return MainTabView(user: User.MOCK_USERS[0])
            .modelContainer(container)
    } catch {
        print("error setting up model container: \(error.localizedDescription)")
        return Text("Empty")
    }
}
