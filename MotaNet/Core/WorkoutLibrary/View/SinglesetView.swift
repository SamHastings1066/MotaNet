//
//  SinglesetView.swift
//  MotaNet
//
//  Created by sam hastings on 10/08/2024.
//

import SwiftUI

struct SinglesetView: View {
    
    @State var viewModel: SinglesetViewModel
    @Binding var isWorkoutEdited: Bool
    
    init(singleset: Singleset, isWorkoutEdited: Binding<Bool>) {
        _viewModel = State(initialValue: SinglesetViewModel(singleset: singleset))
        _isWorkoutEdited = isWorkoutEdited
    }
    
    var body: some View {
        // TODO: move these binding definitions out of view body
        let repsBinding: Binding<String> = Binding {
            if let reps = viewModel.reps {
                return String(reps)
            } else {
                return "-"
            }
        } set: { reps in
            viewModel.reps = Int(reps)
            isWorkoutEdited = true
        }
        
        let weightBinding: Binding<String> = Binding {
            if let weight = viewModel.weight {
                return String(weight)
            } else {
                return "-"
            }
        } set: { weight in
            viewModel.weight = Int(weight)
            isWorkoutEdited = true
        }
        
        HStack {
            ExerciseImageView(imageURLs: viewModel.imageUrls, size: .small)
                .padding(.horizontal,4)
            //Spacer()
            VStack(alignment: .leading) {
                Text(viewModel.exerciseName)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                HStack {
                    VStack{
                        Text("Reps")
                        TextField("", text: repsBinding)
                            .fixedSize()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                        //Text(viewModel.reps == nil ? "-" : "\(viewModel.reps!)")
                    }
                    .font(.footnote)
                    VStack{
                        Text("Weight")
                        TextField("", text: weightBinding)
                            .fixedSize()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                        //Text(viewModel.weight == nil ? "-" : "\(viewModel.weight!)")
                    }
                    .font(.footnote)
                    //.fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    SinglesetView(singleset: WorkoutTemplate.MOCK_WORKOUTS[0].supersets[0].rounds[0].singlesets[0], isWorkoutEdited: .constant(false))
}
