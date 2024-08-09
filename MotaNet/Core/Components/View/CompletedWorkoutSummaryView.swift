//
//  CompletedWorkoutSummaryView.swift
//  MotaNet
//
//  Created by sam hastings on 09/08/2024.
//

import SwiftUI

struct CompletedWorkoutSummaryView: View {
    let workout: WorkoutCompleted
    let stats: WorkoutStats
    
    init(workout: WorkoutCompleted) {
        self.workout = workout
        stats = WorkoutStats.compute(from: workout)
    }
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(workout.name) - \(workout.startTime.formattedAsDayDateMonth())")
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
    CompletedWorkoutSummaryView(workout: WorkoutCompleted.MOCK_WORKOUTS[0])
}
