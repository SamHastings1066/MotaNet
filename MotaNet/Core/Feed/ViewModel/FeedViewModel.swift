//
//  FeedViewModel.swift
//  MotaNet
//
//  Created by sam hastings on 03/09/2024.
//

import Foundation

@Observable
class FeedViewModel {
    var completedWorkouts: [WorkoutCompleted] = []
    var isLoading = true
    var errorMessage: String?
    
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
