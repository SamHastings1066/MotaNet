//
//  ExerciseRowView.swift
//  MotaNet
//
//  Created by sam hastings on 12/08/2024.
//

import SwiftUI

struct ExerciseRowView: View {
    let exercise: Exercise
    var body: some View {
        HStack {
            ExerciseImageView(exercise: exercise, size: .small)
                .padding(.horizontal,4)
            //Spacer()
            Text(exercise.name)
                .font(.subheadline)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    ExerciseRowView(exercise: Exercise.MOCK_EXERCISES[0])
}
