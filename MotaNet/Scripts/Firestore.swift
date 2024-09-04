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
import FirebaseAuth

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

class MockDataUploader {
    private let auth = Auth.auth()
    var userSession: FirebaseAuth.User?
    
    func createUser(email: String, password: String, username: String) async throws {
        do {
            let result = try await auth.createUser(withEmail: email, password: password)
            self.userSession = result.user
            await self.uploadUserData(uid: result.user.uid, username: username, email: email)
            try await FirestoreUploader.uploadMockWorkouts(uid: result.user.uid)
        } catch {
            print("DEBUG: Failed to register user with error \(error.localizedDescription)")
        }
    }
    
    private func uploadUserData(uid: String, username: String, email: String) async {
        let user = User(id: uid, username: username, email: email)
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try? await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
    }
}

struct FirestoreUploader {
    static func uploadMockWorkouts(uid: String) async throws {
        let db = Firestore.firestore()
        
        // Upload Workout Templates
        for idx in WorkoutTemplate.MOCK_WORKOUTS.indices {
            var workout = WorkoutTemplate.MOCK_WORKOUTS[idx]
            workout.userId = uid
            
            let workoutDoc = db.collection("WorkoutTemplates")
                .document(workout.id)
            
            try workoutDoc.setData(from: workout)
            
            // Uncomment to create seperate collections
//            // Upload Supersets
//            for superset in workout.supersets {
//                let supersetDoc = workoutDoc.collection("Supersets").document(superset.id)
//                try supersetDoc.setData(from: superset)
//                
//                // Upload Rounds
//                for round in superset.rounds {
//                    let roundDoc = supersetDoc.collection("Rounds").document(round.id)
//                    try roundDoc.setData(from: round)
//                    
//                    // Upload Singlesets
//                    for singleset in round.singlesets {
//                        let singlesetDoc = roundDoc.collection("Singlesets").document(singleset.id)
//                        try singlesetDoc.setData(from: singleset)
//                    }
//                }
//            }
        }
        
        // Upload Completed Workouts
        for idx in WorkoutCompleted.MOCK_WORKOUTS.indices {
            var workout = WorkoutCompleted.MOCK_WORKOUTS[idx]
            workout.userId = uid
            
            let workoutDoc = db.collection("WorkoutsCompleted")
                .document(workout.id)
            
            try workoutDoc.setData(from: workout)
            
            // Uncomment to create seperate collections
//            // Upload Supersets
//            for superset in workout.supersets {
//                let supersetDoc = workoutDoc.collection("Supersets").document(superset.id)
//                try supersetDoc.setData(from: superset)
//                
//                // Upload Rounds
//                for round in superset.rounds {
//                    let roundDoc = supersetDoc.collection("Rounds").document(round.id)
//                    try roundDoc.setData(from: round)
//                    
//                    // Upload Singlesets
//                    for singleset in round.singlesets {
//                        let singlesetDoc = roundDoc.collection("Singlesets").document(singleset.id)
//                        try singlesetDoc.setData(from: singleset)
//                    }
//                }
//            }
        }
    }
}

