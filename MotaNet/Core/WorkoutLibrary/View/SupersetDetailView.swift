//
//  SupersetDetailView.swift
//  MotaNet
//
//  Created by sam hastings on 10/08/2024.
//

import SwiftUI

struct SupersetDetailView: View {
    @State var viewModel: SupersetDetailViewModel
    
    init(superset: Superset) {
        _viewModel = State(initialValue: SupersetDetailViewModel(superset: superset))
    }
    
    var body: some View {
        List {
            ForEach(viewModel.superset.rounds) { round in
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
                viewModel.addRound()
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
