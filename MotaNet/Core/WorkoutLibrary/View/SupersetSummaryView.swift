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
                    HStack {
                        ExerciseImageView(exercise: exerciseSummary.exercise, size: .small)
                            .padding(.horizontal,4)
                        //Spacer()
                        VStack(alignment: .leading) {
                            Text(exerciseSummary.exercise.name)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            HStack {
                                VStack{
                                    Text("Reps")
                                    Text(exerciseSummary.consistentReps == nil ? "-" : "\(exerciseSummary.consistentReps!)")
                                }
                                .font(.footnote)
                                //.fontWeight(.semibold)
                                VStack{
                                    Text("Weight")
                                    Text(exerciseSummary.consistentWeight == nil ? "-" : "\(exerciseSummary.consistentWeight!)")
                                }
                                .font(.footnote)
                                //.fontWeight(.semibold)
                            }
                        }
                    }
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
