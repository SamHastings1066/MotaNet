//
//  Firestore.swift
//  MotaNet
//
//  Created by sam hastings on 15/08/2024.
//

/*
This file contains scripts used to set up the Firestore database.
e.g. `uploadExercisesToFirestore` can be used by adding an onAppear modifier to ContentView as follows:
     .onAppear {
         uploadExercisesToFirestore(jsonFilePath: "exercises")
     }
This will upload all of the exercises in the exercises.json file into individual exercise documents within the "exercises" collection in Firestore.
*/


// TODO: Delete this file before production build

import Foundation
import FirebaseFirestore

func uploadExercisesToFirestore(jsonFilePath: String) {
    guard let url = Bundle.main.url(forResource: jsonFilePath, withExtension: "json") else {
        print("Could not find \(jsonFilePath).json")
        return
    }

    do {
        // Read and parse the JSON file into an array of dictionaries
        let data = try Data(contentsOf: url)
        if let exercises = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
            
            let db = Firestore.firestore()

            for exercise in exercises {
                if let exerciseId = exercise["id"] as? String {
                    db.collection("exercises").document(exerciseId).setData(exercise) { error in
                        if let error = error {
                            print("Error uploading exercise \(exerciseId): \(error)")
                        } else {
                            print("Successfully uploaded exercise \(exerciseId)")
                        }
                    }
                } else {
                    print("Exercise ID is missing or invalid for exercise: \(exercise)")
                }
            }
        } else {
            print("Error parsing JSON file.")
        }

    } catch {
        print("Error reading or decoding JSON file: \(error)")
    }
}


struct FirestoreUploader {
    static func uploadMockWorkouts() async throws {
        let db = Firestore.firestore()
        
        // Upload Workout Templates
        for workout in WorkoutTemplate.MOCK_WORKOUTS {
            let workoutDoc = db.collection("WorkoutTemplates")
                .document(workout.id)
            
            try workoutDoc.setData(from: workout)
            
            // Upload Supersets
            for superset in workout.supersets {
                let supersetDoc = workoutDoc.collection("Supersets").document(superset.id)
                try supersetDoc.setData(from: superset)
                
                // Upload Rounds
                for round in superset.rounds {
                    let roundDoc = supersetDoc.collection("Rounds").document(round.id)
                    try roundDoc.setData(from: round)
                    
                    // Upload Singlesets
                    for singleset in round.singlesets {
                        let singlesetDoc = roundDoc.collection("Singlesets").document(singleset.id)
                        try singlesetDoc.setData(from: singleset)
                    }
                }
            }
        }
        
        // Upload Completed Workouts
        for workout in WorkoutCompleted.MOCK_WORKOUTS {
            let workoutDoc = db.collection("WorkoutsCompleted")
                .document(workout.id)
            
            try workoutDoc.setData(from: workout)
            
            // Upload Supersets
            for superset in workout.supersets {
                let supersetDoc = workoutDoc.collection("Supersets").document(superset.id)
                try supersetDoc.setData(from: superset)
                
                // Upload Rounds
                for round in superset.rounds {
                    let roundDoc = supersetDoc.collection("Rounds").document(round.id)
                    try roundDoc.setData(from: round)
                    
                    // Upload Singlesets
                    for singleset in round.singlesets {
                        let singlesetDoc = roundDoc.collection("Singlesets").document(singleset.id)
                        try singlesetDoc.setData(from: singleset)
                    }
                }
            }
        }
    }
}

