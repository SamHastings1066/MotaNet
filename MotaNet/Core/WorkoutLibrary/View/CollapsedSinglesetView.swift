//
//  CollapsedSinglesetView.swift
//  MotaNet
//
//  Created by sam hastings on 24/09/2024.
//

import SwiftUI

struct CollapsedSinglesetView: View {
    @State var viewModel: CollapsedSinglesetViewModel
    
    init(collapsedSingleset: CollapsedSingleset) {
        _viewModel = State(initialValue: CollapsedSinglesetViewModel(collapsedSingleset: collapsedSingleset))
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
                        Text(viewModel.reps == nil ? "-" : "\(viewModel.reps!)")
                    }
                    .font(.footnote)
                    VStack{
                        Text("Weight")
                        Text(viewModel.weight == nil ? "-" : "\(viewModel.weight!)")
                    }
                    .font(.footnote)
                }
            }
        }
    }
}

#Preview {
    CollapsedSinglesetView(collapsedSingleset: CollapsedSingleset(weight: 100, reps: 10, exerciseName: Exercise.MOCK_EXERCISES[0].name, exerciseImageUrls: Exercise.MOCK_EXERCISES[0].imageURLs) )
}
