//
//  CompletedWorkoutSummaryListView.swift
//  MotaNet
//
//  Created by sam hastings on 09/08/2024.
//

import SwiftUI

struct CompletedWorkoutSummaryListView: View {
    let workouts: [WorkoutCompleted]
    var body: some View {
        ForEach(workouts) { workout in
            CompletedWorkoutSummaryView(workout: workout)
        }
    }
}

#Preview {
    CompletedWorkoutSummaryListView(workouts: WorkoutCompleted.MOCK_WORKOUTS)
}
