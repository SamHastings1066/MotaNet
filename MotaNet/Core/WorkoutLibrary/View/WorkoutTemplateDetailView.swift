//
//  WorkoutTemplateDetailView.swift
//  MotaNet
//
//  Created by sam hastings on 10/08/2024.
//

import SwiftUI

struct WorkoutTemplateDetailView: View {
    let workout: WorkoutTemplate
    var body: some View {
        List {
            ForEach(workout.supersets) {superset in
                NavigationLink(value: superset) {
                    SupersetSummaryView(superset: superset)
                }
                
            }
        }
        .navigationTitle(workout.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Superset.self) { superset in
            SupersetDetailView(superset: superset)
        }
    }
}

#Preview {
    NavigationStack {
        WorkoutTemplateDetailView(workout: WorkoutTemplate.MOCK_WORKOUTS[1])
    }
}
