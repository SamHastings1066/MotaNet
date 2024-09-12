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
    var templateWorkoutsForUser: [WorkoutTemplate] = []
    var templateWorkoutsExcludingUser: [WorkoutTemplate] = []
    var isLoading = true
    var isLoadingWorkoutsForUser = true
    var isLoadingWorkoutsExcludingUser = true
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
    
    func loadAllTemplateWorkoutsForUser(uid: String) async {
        isLoadingWorkoutsForUser = true
        do {
            templateWorkoutsForUser = try await WorkoutService.fetchAllTemplateWorkoutsForUser(uid: uid)
        } catch {
            print("Could not load template workouts for user \(uid): \(error.localizedDescription)")
        }
        isLoadingWorkoutsForUser = false
    }
    
    func loadAllTemplateWorkoutsExcludingUser(uid: String) async {
        isLoadingWorkoutsExcludingUser = true
        do {
            templateWorkoutsExcludingUser = try await WorkoutService.fetchAllTemplateWorkoutsExcludingUser(uid: uid)
        } catch {
            print("Could not load template workouts excluding user \(uid): \(error.localizedDescription)")
        }
        isLoadingWorkoutsExcludingUser = false
    }
    
    func updateWorkout(_ updatedWorkout: WorkoutTemplate) {
        if let index = templateWorkoutsForUser.firstIndex(where: { $0.id == updatedWorkout.id }) {
            templateWorkoutsForUser[index] = updatedWorkout
        }
    }
    
    func createNewWorkout(userId uid: String) -> WorkoutTemplate {
        WorkoutTemplate(name: "New Workout", supersets: [], userId: uid)
    }
}
