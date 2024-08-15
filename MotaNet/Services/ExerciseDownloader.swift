//
//  ExerciseDownloader.swift
//  MotaNet
//
//  Created by sam hastings on 15/08/2024.
//

import FirebaseFirestore
import SwiftData

struct ExerciseDownloader {
    
    func downloadExercisesIfNeeded(context: ModelContext) async throws {
        let existingExercises = try context.fetch(FetchDescriptor<Exercise>())
        
        guard existingExercises.isEmpty else {
            print("Exercises already exist locally.")
            return
        }
        
        // Fetch exercises from Firestore
        let exercises = try await fetchExercisesFromFirestore()
        
        // Save exercises to SwiftData
        try saveExercisesToLocalDatabase(exercises: exercises, context: context)
        
        print("Exercises successfully downloaded and saved.")
    }
    
    private func fetchExercisesFromFirestore() async throws -> [Exercise] {
        let db = Firestore.firestore()
        let snapshot = try await db.collection("exercises").getDocuments()
        
        return snapshot.documents.compactMap { document in
            Exercise(data: document.data())
        }
    }
    
    private func saveExercisesToLocalDatabase(exercises: [Exercise], context: ModelContext) throws {
        for exercise in exercises {
            context.insert(exercise)
        }
        
        try context.save()
    }
}

