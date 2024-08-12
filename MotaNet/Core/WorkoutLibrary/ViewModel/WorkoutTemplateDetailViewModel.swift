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
    
    init(workout: WorkoutTemplate) {
        self.workout = workout
    }
    
    func removeSuperset(at offsets: IndexSet) {
        workout.supersets.remove(atOffsets: offsets)
    }
    
    func moveSuperset(from source: IndexSet, to destination: Int) {
        workout.supersets.move(fromOffsets: source, toOffset: destination)
    }
}
