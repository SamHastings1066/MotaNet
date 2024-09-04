//
//  ProfileViewModel.swift
//  MotaNet
//
//  Created by sam hastings on 04/09/2024.
//

import Foundation

@Observable
class ProfileViewModel {
    
    let user: User
    var workouts: [WorkoutCompleted] = []
    var isLoadingWorkouts = true
    
    init(user: User) {
        self.user = user
    }
    
    func loadWorkouts() async {
        isLoadingWorkouts = true
        do {
            workouts = try await WorkoutService.fetchAllCompletedWorkoutsForUser(uid: user.id)
        } catch {
            print("Could not fetch workouts for user \(user.id): \(error.localizedDescription)")
        }
        isLoadingWorkouts = false
    }
    
}
