//
//  SwiftDataManager.swift
//  MotaNet
//
//  Created by sam hastings on 15/08/2024.
//

import Foundation
import SwiftData

@MainActor
struct SwiftDataManager {
    static var shared = SwiftDataManager(inMemoryOnly: false)
    static var preview = SwiftDataManager(inMemoryOnly: true)
    
    var container: ModelContainer
    
    init(inMemoryOnly:Bool) {
        do {
            self.container = try ModelContainer(for: Exercise.self, configurations: ModelConfiguration(isStoredInMemoryOnly: inMemoryOnly))
            
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
            fatalError("Failed to create container")
        }
    }
}
