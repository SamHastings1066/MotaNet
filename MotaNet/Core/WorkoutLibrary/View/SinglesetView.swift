//
//  SinglesetView.swift
//  MotaNet
//
//  Created by sam hastings on 10/08/2024.
//

import SwiftUI

struct SinglesetView: View {
    let exercise: Exercise
    let reps: Int?
    let weight: Int?
    var body: some View {
        HStack {
            ExerciseImageView(exercise: exercise, size: .small)
                .padding(.horizontal,4)
            //Spacer()
            VStack(alignment: .leading) {
                Text(exercise.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                HStack {
                    VStack{
                        Text("Reps")
                        Text(reps == nil ? "-" : "\(reps!)")
                    }
                    .font(.footnote)
                    //.fontWeight(.semibold)
                    VStack{
                        Text("Weight")
                        Text(weight == nil ? "-" : "\(weight!)")
                    }
                    .font(.footnote)
                    //.fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    SinglesetView(exercise: Exercise.MOCK_EXERCISES[0], reps: 12, weight: 70)
}
