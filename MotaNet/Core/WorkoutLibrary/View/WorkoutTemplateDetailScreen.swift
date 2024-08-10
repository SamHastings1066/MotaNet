//
//  WorkoutTemplateDetailScreen.swift
//  MotaNet
//
//  Created by sam hastings on 10/08/2024.
//

import SwiftUI

struct WorkoutTemplateDetailScreen: View {
    let workout: WorkoutTemplate
    var body: some View {
        List {
            ForEach(workout.supersets) {superset in
                Text("Superset")
            }
        }
    }
}

#Preview {
    NavigationStack {
        WorkoutTemplateDetailScreen(workout: WorkoutTemplate.MOCK_WORKOUTS[0])
    }
}
