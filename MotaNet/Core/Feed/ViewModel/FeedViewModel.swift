//
//  FeedViewModel.swift
//  MotaNet
//
//  Created by sam hastings on 03/09/2024.
//

import Foundation
import Firebase

@Observable
class FeedViewModel {
    var completedWorkouts: [WorkoutCompleted] = []
    var isLoading = true
    var errorMessage: String?
    
    private var listener: ListenerRegistration?
    
    init() {
        addWorkoutsListener()
    }
    
    deinit {
        listener?.remove()
    }
    
    func addWorkoutsListener() {
        isLoading = true
        listener = WorkoutService.db.collection("WorkoutsCompleted")
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self = self else { return }
                if let error = error {
                    self.errorMessage = "Could not load completed workouts: \(error.localizedDescription)"
                    self.isLoading = false
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    self.errorMessage = "No workouts found."
                    self.isLoading = false
                    return
                }
                
                self.completedWorkouts = documents.compactMap { try? $0.data(as: WorkoutCompleted.self) }
                self.errorMessage = nil
                self.isLoading = false
            }
    }
    
    func loadAllCompletedWorkouts() async {
        isLoading = true
        do {
            completedWorkouts = try await WorkoutService.fetchAllCompletedWorkouts()
            errorMessage = nil
        } catch {
            errorMessage = "Could not load completed workouts: \(error.localizedDescription)"
        }
        isLoading = false
    }
}
