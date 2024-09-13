//
//  CompletedWorkoutsForDayView.swift
//  MotaNet
//
//  Created by sam hastings on 09/08/2024.
//

import SwiftUI

struct CompletedWorkoutsForDayView: View {
    @State var viewModel: CompletedWorkoutsForDayViewModel
    
    init(workouts: [WorkoutCompleted]) {
        _viewModel = State(initialValue: CompletedWorkoutsForDayViewModel(completedWorkoutsForUser: workouts))
    }
    
    var body: some View {
        List {
            ForEach(viewModel.completedWorkoutsForUser) { completedWorkout in
                CompletedWorkoutSummaryView(workout: completedWorkout)
            }
            .onDelete(perform: viewModel.deleteWorkout)
        }
        .listStyle(.inset)
    }
}

#Preview {
    CompletedWorkoutsForDayView(workouts: WorkoutCompleted.MOCK_WORKOUTS)
}
