//
//  TemplateWorkoutSummaryView.swift
//  MotaNet
//
//  Created by sam hastings on 09/08/2024.
//

import SwiftUI

struct TemplateWorkoutSummaryView: View {
    let workout: WorkoutTemplate
    let stats: WorkoutStats
    
    init(workout: WorkoutTemplate) {
        self.workout = workout
        stats = WorkoutStats.compute(from: workout)
    }
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(workout.name))")
                .font(.headline)
            Text("Reps: \(stats.totalReps)")
                .font(.subheadline)
                .fontWeight(.semibold)
            Text("Volume: \(stats.totalVolume)")
                .font(.subheadline)
                .fontWeight(.semibold)
            Text("Exercises: \(stats.uniqueExerciseNames.joined(separator: ", "))")
                .font(.subheadline)
                .fontWeight(.semibold)
            PieChartView(musclesUsed: stats.musclesUsed, maxMuscles: 3)
        }
        
            
    }
}

#Preview {
    TemplateWorkoutSummaryView(workout: WorkoutTemplate.MOCK_WORKOUTS[0])
}
