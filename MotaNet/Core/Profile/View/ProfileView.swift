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
        NavigationStack {
            List {
                // Header
                ProfileHeaderView(user: viewModel.user)
                // post grid view
                if viewModel.isLoading {
                    ProgressView()
                        .task {
                            await viewModel.loadWorkoutsForUser()
                        }
                } else {
                    ForEach(viewModel.completedWorkoutsForUser) { workout in
                        CompletedWorkoutSummaryView(workout: workout)
                    }
                    .onDelete(perform: viewModel.deleteWorkout)
                }
            }
            .listStyle(.inset)
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                NavigationLink(value: viewModel.user) {
                    Image(systemName: "line.3.horizontal")
                }
            }
            .navigationDestination(for: User.self) { user in
                SettingsView(user: viewModel.user)
            }
        }
    }
}

#Preview {
    ProfileView(user: User.MOCK_USERS[0])
}
