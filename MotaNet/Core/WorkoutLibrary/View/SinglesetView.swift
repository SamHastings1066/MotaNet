//
//  SinglesetView.swift
//  MotaNet
//
//  Created by sam hastings on 10/08/2024.
//

import SwiftUI

struct SinglesetView: View {
    let imageUrls: [String]
    let exerciseName: String
    let reps: Int?
    let weight: Int?
    var body: some View {
        HStack {
            ExerciseImageView(imageURLs: imageUrls, size: .small)
                .padding(.horizontal,4)
            //Spacer()
            VStack(alignment: .leading) {
                Text(exerciseName)
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
    SinglesetView(imageUrls: Exercise.MOCK_EXERCISES[0].images, exerciseName: Exercise.MOCK_EXERCISES[0].name, reps: 12, weight: 70)
}
