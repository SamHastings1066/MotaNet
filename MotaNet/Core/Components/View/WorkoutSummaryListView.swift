//
//  WorkoutSummaryListView.swift
//  MotaNet
//
//  Created by sam hastings on 09/08/2024.
//

import SwiftUI

struct WorkoutSummaryListView: View {
    var body: some View {
        ForEach(WorkoutCompleted.MOCK_WORKOUTS) { workout in
            Text(workout.name)
        }
    }
}

#Preview {
    WorkoutSummaryListView()
}
