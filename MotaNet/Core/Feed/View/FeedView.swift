//
//  FeedView.swift
//  MotaNet
//
//  Created by sam hastings on 09/08/2024.
//

import SwiftUI

struct FeedView: View {
    
    @State var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if viewModel.isLoading {
                    Spacer()
                    ProgressView()
                        .task {
                            await viewModel.loadAllCompletedWorkouts()
                        }
                    Spacer()
                } else {
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                            .padding()
                    } else {
                        LazyVStack(spacing: 32) {
                            //ForEach(WorkoutCompleted.MOCK_WORKOUTS) { workout in // Uses mock data
                            ForEach(viewModel.completedWorkouts) { workout in
                                FeedCell(workout: workout)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Feed")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    // TODO: Add logo
                    Image("logo")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                }
            }
        }
    }
}

#Preview {
    FeedView()
}
