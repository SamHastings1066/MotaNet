//
//  SupersetSummaryView.swift
//  MotaNet
//
//  Created by sam hastings on 10/08/2024.
//

import SwiftUI

struct SupersetSummaryView: View {
    
    @State var viewModel: SupersetSummaryViewModel
    
    init(superset: Superset) {
        self._viewModel = State(initialValue: SupersetSummaryViewModel(superset: superset))
    }
    
    var body: some View {
        HStack {
            VStack(alignment:.leading) {
                ForEach(viewModel.exerciseSummaries) { exerciseSummary in
                    SinglesetView(imageUrls: exerciseSummary.imageUrls, exerciseName: exerciseSummary.exerciseName, reps: exerciseSummary.consistentReps, weight: exerciseSummary.consistentWeight)
                }
            }
            Spacer()
            VStack {
                VStack{
                    Text("Rounds")
                    Text("\(viewModel.numRounds)")
                }
                VStack{
                    Text("Rest")
                    Text(viewModel.consistentRest == nil ? "-" : "30")
                }
            }
            .font(.footnote)
        }
    }
}

#Preview {
    SupersetSummaryView(superset: WorkoutTemplate.MOCK_WORKOUTS[1].supersets[0])
}
