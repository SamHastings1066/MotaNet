//
//  CompletedWorkoutsForDayViewModel.swift
//  MotaNet
//
//  Created by sam hastings on 13/09/2024.
//

import Foundation

@Observable
class CompletedWorkoutsForDayViewModel {
    var completedWorkoutsForUser: [WorkoutCompleted]
    
    init(completedWorkoutsForUser: [WorkoutCompleted]) {
        self.completedWorkoutsForUser = completedWorkoutsForUser
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
