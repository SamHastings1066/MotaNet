//
//  SupersetDetailView.swift
//  MotaNet
//
//  Created by sam hastings on 10/08/2024.
//

import SwiftUI

struct SupersetDetailView: View {
    let superset: Superset
    
    // TODO: Consier moving to ViewModel
    private func addRound() {
        superset.addRound()
    }
    
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
            Button {
                addRound()
            } label: {
                HStack {
                    Spacer()
                    Image(systemName: "plus")
                    Text("Add round")
                    Spacer()
                }
            }
            

        }
        .listStyle(.inset)
    }
}

#Preview {
    SupersetDetailView(superset: WorkoutTemplate.MOCK_WORKOUTS[1].supersets[0])
}
