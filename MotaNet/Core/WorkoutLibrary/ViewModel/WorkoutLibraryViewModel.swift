//
//  WorkoutLibraryViewModel.swift
//  MotaNet
//
//  Created by sam hastings on 03/09/2024.
//

import Foundation

@Observable
class WorkoutLibraryViewModel {
    
    var templateWorkouts: [WorkoutTemplate] = []
    var isLoading = true
    var errorMessage: String?
    
    func loadAllTemplateWorkouts() async {
        isLoading = true
        do {
            templateWorkouts = try await WorkoutService.fetchAllTemplateWorkouts()
            errorMessage = nil
        } catch {
            errorMessage = "Could not load template workouts: \(error.localizedDescription)"
        }
        isLoading = false
    }
}
