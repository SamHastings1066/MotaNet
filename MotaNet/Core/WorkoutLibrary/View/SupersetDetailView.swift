//
//  SupersetDetailView.swift
//  MotaNet
//
//  Created by sam hastings on 10/08/2024.
//

import SwiftUI

struct SupersetDetailView: View {
    let superset: Superset
    var body: some View {
        List {
            ForEach(superset.rounds) { round in
                VStack(alignment: .listRowSeparatorLeading) {
                    ForEach(round.singlesets) { singletset in
                        SinglesetView(imageUrls: singletset.exerciseImageUrls, exerciseName: singletset.exerciseName, reps: singletset.reps, weight: singletset.weight)
                    }
                    HStack {
                        Spacer()
                        Text("Rest")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        Text("\(round.rest)")
                            .font(.footnote)
                        Spacer()
                    }
                }
            }
        }
        .listStyle(.inset)
    }
}

#Preview {
    SupersetDetailView(superset: WorkoutTemplate.MOCK_WORKOUTS[1].supersets[0])
}
