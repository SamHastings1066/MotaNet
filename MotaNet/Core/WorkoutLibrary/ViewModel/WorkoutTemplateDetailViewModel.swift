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
    
    init(workout: WorkoutTemplate) {
        self.workout = workout
    }
    
    func removeSuperset(at offsets: IndexSet) {
        workout.supersets.remove(atOffsets: offsets)
        isWorkoutEditted = true
    }
    
    func moveSuperset(from source: IndexSet, to destination: Int) {
        workout.supersets.move(fromOffsets: source, toOffset: destination)
        isWorkoutEditted = true
    }
    
    func saveWorkout() {
        do {
            try WorkoutService.updateTemplateWorkout(workout: workout)
            isWorkoutEditted = false
        } catch {
            print("Could not update workout: \(error.localizedDescription)")
        }
    }
}
