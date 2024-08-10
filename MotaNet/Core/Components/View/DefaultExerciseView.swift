//
//  DefaultExerciseView.swift
//  MotaNet
//
//  Created by sam hastings on 10/08/2024.
//

import SwiftUI

struct DefaultExerciseView: View {
    let exercise: Exercise
    var body: some View {
        if let image = UIImage(named: exercise.imageURLs[0]) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        } else {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 100, height: 100)
                .foregroundStyle(.gray)
                .overlay(alignment: .center) {             Image(systemName: "figure.run")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundStyle(Color(.white))
                }
        }
    }
}

#Preview {
    Group {
        DefaultExerciseView(exercise: Exercise.MOCK_EXERCISES[0]).padding()
        DefaultExerciseView(exercise: Exercise.MOCK_EXERCISES[1])
    }
}
