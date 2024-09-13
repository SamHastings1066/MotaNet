//
//  ProfileViewModel.swift
//  MotaNet
//
//  Created by sam hastings on 04/09/2024.
//

import Foundation
import Firebase

@Observable
class ProfileViewModel {
    
    let user: User
    var completedWorkoutsForUser: [WorkoutCompleted] = []
    var isLoading = true
    var errorMessage: String?
    
    private var listener: ListenerRegistration?
    
    init(user: User) {
        self.user = user
        addWorkoutsListener()
    }
    
    deinit {
        listener?.remove()
    }
    
    // TODO: This function is repeated in FeedViewModel and ProfileViewModel. Refactor architecture.
    func addWorkoutsListener() {
        isLoading = true
        listener = WorkoutService.db.collection("WorkoutsCompleted").addSnapshotListener { [weak self] snapshot, error in
            guard let self else { return }
            if let error {
                self.errorMessage = "Could not load completed workouts: \(error.localizedDescription)"
                self.isLoading = false
                return
            }
            
            guard let documents = snapshot?.documents else {
                self.errorMessage = "No workouts found."
                self.isLoading = false
                return
            }
            
            self.completedWorkoutsForUser = documents.compactMap{ try? $0.data(as: WorkoutCompleted.self) }
            self.errorMessage = nil
            self.isLoading = false
        }
    }
    
    func loadWorkoutsForUser() async {
        isLoading = true
        do {
            completedWorkoutsForUser = try await WorkoutService.fetchAllCompletedWorkoutsForUser(uid: user.id)
            errorMessage = nil
        } catch {
            errorMessage = "Could not fetch workouts for user \(user.id): \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    func deleteWorkout(at offsets: IndexSet) {
        for index in offsets {
            let workout = completedWorkoutsForUser[index]
            Task {
                do {
                    try await WorkoutService.deleteCompletedWorkout(workout)
                } catch {
                    print("Could not delete workout: \(error.localizedDescription)")
                }
            }
        }
        completedWorkoutsForUser.remove(atOffsets: offsets)
    }
    
}
