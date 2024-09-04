//
//  ProfileView.swift
//  MotaNet
//
//  Created by sam hastings on 08/08/2024.
//

import SwiftUI

struct ProfileView: View {
    
    @State var viewModel: ProfileViewModel
    
    init(user: User) {
        _viewModel = State(initialValue: ProfileViewModel(user: user))
    }
    
    var body: some View {
        ScrollView {
            // Header
            ProfileHeaderView(user: viewModel.user)
            // post grid view
            if viewModel.isLoadingWorkouts {
                ProgressView()
                    .task {
                        await viewModel.loadWorkouts()
                    }
            } else {
                    ForEach(viewModel.workouts) { workout in
                            CompletedWorkoutSummaryView(workout: workout)
                        }
                        .padding()
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ProfileView(user: User.MOCK_USERS[0])
}
