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
    
    private var repsBinding: Binding<String> {
        Binding<String> {
            if let reps = viewModel.reps {
                return String(reps)
            } else {
                return "-"
            }
        } set: { reps in
            viewModel.reps = Int(reps)
            isWorkoutEdited = true
        }
    }
    
    private var weightBinding: Binding<String> {
        Binding<String> {
            if let weight = viewModel.weight {
                return String(weight)
            } else {
                return "-"
            }
        } set: { weight in
            viewModel.weight = Int(weight)
            isWorkoutEdited = true
        }
    }
    
    var body: some View {
        
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
                    }
                    .font(.footnote)
                    VStack{
                        Text("Weight")
                        TextField("", text: weightBinding)
                            .fixedSize()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                    }
                    .font(.footnote)
                }
            }
        }
    }
}

#Preview {
    SinglesetView(singleset: WorkoutTemplate.MOCK_WORKOUTS[0].supersets[0].rounds[0].singlesets[0], isWorkoutEdited: .constant(false))
}
