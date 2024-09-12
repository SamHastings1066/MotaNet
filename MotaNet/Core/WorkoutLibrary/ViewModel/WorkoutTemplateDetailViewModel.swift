//
//  WorkoutTemplateDetailViewModel.swift
//  MotaNet
//
//  Created by sam hastings on 12/08/2024.
//

import Foundation

@Observable
class WorkoutTemplateDetailViewModel{
    var workout: WorkoutTemplate
    var isWorkoutEditted = false
    var onSave: ((WorkoutTemplate) -> Void)?
    var newlyCreated: Bool
    
    init(workout: WorkoutTemplate, newlyCreated: Bool = false, onSave: ((WorkoutTemplate) -> Void)? = nil) {
        self.workout = workout
        self.newlyCreated = newlyCreated
        self.onSave = onSave
    }
    
    func removeSuperset(at offsets: IndexSet) {
        workout.supersets.remove(atOffsets: offsets)
        isWorkoutEditted = true
    }
    
    func moveSuperset(from source: IndexSet, to destination: Int) {
        workout.supersets.move(fromOffsets: source, toOffset: destination)
        isWorkoutEditted = true
    }
    
    func renameWorkout(_ name: String) {
        workout.name = name
        isWorkoutEditted = true
    }
    
    func saveWorkout() {
        do {
            workout.lastUpdated = Date()
            try WorkoutService.updateTemplateWorkout(workout: workout)
            isWorkoutEditted = false
            onSave?(workout)
        } catch {
            print("Could not update workout: \(error.localizedDescription)")
        }
    }
}
