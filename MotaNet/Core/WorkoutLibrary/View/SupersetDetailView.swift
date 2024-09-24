//
//  SupersetDetailView.swift
//  MotaNet
//
//  Created by sam hastings on 10/08/2024.
//

import SwiftUI

struct SupersetDetailView: View {
    @State var viewModel: SupersetDetailViewModel
    @Binding var isWorkoutEdited: Bool
    
    init(supersetEditContext: SupersetEditContext) {
        _viewModel = State(initialValue: SupersetDetailViewModel(superset: supersetEditContext.superset))
        self._isWorkoutEdited = supersetEditContext.isWorkoutEdited
        print("SupersetDetailView initialised")
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
                isWorkoutEdited = true
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
    SupersetDetailView(supersetEditContext: SupersetEditContext(superset: WorkoutTemplate.MOCK_WORKOUTS[1].supersets[0], isWorkoutEdited: .constant(false)))
}
