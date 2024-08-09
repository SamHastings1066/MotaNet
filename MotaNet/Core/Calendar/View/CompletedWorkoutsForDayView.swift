//
//  CompletedWorkoutsForDayView.swift
//  MotaNet
//
//  Created by sam hastings on 09/08/2024.
//

import SwiftUI

struct CompletedWorkoutsForDayView: View {
    let workouts: [WorkoutCompleted]
    
    var body: some View {
        ForEach(workouts) { workout in
            CompletedWorkoutSummaryView(workout: workout)
        }
        .padding()
    }
}

#Preview {
    CompletedWorkoutsForDayView(workouts: WorkoutCompleted.MOCK_WORKOUTS)
}
