//
//  MotaNetApp.swift
//  MotaNet
//
//  Created by sam hastings on 08/08/2024.
//

import SwiftUI
import FirebaseCore
import SwiftData

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct MotaNetApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Exercise.self]) { result in
                    do {
                        let container = try result.get()
                        let descriptor = FetchDescriptor<Exercise>()
                        let existingExercises = try container.mainContext.fetch(descriptor)
                        guard existingExercises.isEmpty else {
                            print("Exercises already exist")
                            return
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
                    } catch {
                        print("error setting up model container: \(error.localizedDescription)")
                    }
                }
                .task {
                    do {
                        // Run setup scripts here
                        //let uploader = MockDataUploader()
                        //try await uploader.createUser(email: "venom@example.com", password: "123456", username: "Venom")
                    } catch {
                        print("Could run script")
                    }
                }
            
        }
    }
}

