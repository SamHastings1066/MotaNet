//
//  WorkoutService.swift
//  MotaNet
//
//  Created by sam hastings on 03/09/2024.
//

import Foundation
import Firebase

struct WorkoutService {
    
    func fetchAllTemplateWorkouts() async throws -> [WorkoutTemplate] {
        let snapshot = try await Firestore.firestore().collection("WorkoutTemplates").getDocuments()
        return snapshot.documents.compactMap{ try? $0.data(as: WorkoutTemplate.self)}
    }
    
    func fetchAllCompletedWorkouts() async throws -> [WorkoutCompleted] {
        let snapshot = try await Firestore.firestore().collection("WorkoutsCompleted").getDocuments()
        return snapshot.documents.compactMap{ try? $0.data(as: WorkoutCompleted.self)}
    }
}
