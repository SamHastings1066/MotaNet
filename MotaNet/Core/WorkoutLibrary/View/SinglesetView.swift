//
//  SinglesetView.swift
//  MotaNet
//
//  Created by sam hastings on 10/08/2024.
//

import SwiftUI

struct SinglesetView: View {
    
    @State var viewModel: SinglesetViewModel
    
    init(singleset: Singleset) {
        _viewModel = State(initialValue: SinglesetViewModel(singleset: singleset))
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
                    //.fontWeight(.semibold)
                    VStack{
                        Text("Weight")
                        Text(viewModel.weight == nil ? "-" : "\(viewModel.weight!)")
                    }
                    .font(.footnote)
                    //.fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    SinglesetView(singleset: WorkoutTemplate.MOCK_WORKOUTS[0].supersets[0].rounds[0].singlesets[0])
}
