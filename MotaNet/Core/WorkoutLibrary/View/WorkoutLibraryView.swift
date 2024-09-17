//
//  WorkoutLibraryView.swift
//  MotaNet
//
//  Created by sam hastings on 09/08/2024.
//

import SwiftUI

struct WorkoutLibraryView: View {
    
    enum LibraryType: String, CaseIterable, Identifiable {
        case saved, community
        var id: Self { self }
    }
    
    @State private var selectedLibrary: LibraryType = .saved
    @State var searchText = ""
    @State var viewModel = WorkoutLibraryViewModel()
    @State private var isNewlyCreatedWorkout = false
    @State var newWorkout = WorkoutTemplate(name: "New Workout", supersets: [])
    let user: User
    
    var body: some View {
        NavigationStack {
            
            // Header
            Picker("Library", selection: $selectedLibrary) {
                ForEach(LibraryType.allCases) { type in
                    Text(type.rawValue.capitalized)
                }
            }
            .padding()
            .pickerStyle(.segmented)
            .searchable(text: $searchText)
            .navigationTitle("Workout Library")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button(action: {
                    isNewlyCreatedWorkout = true
                    newWorkout = viewModel.createNewWorkout(userId: user.id)
                }, label: {
                    Image(systemName: "plus")
                })
            }
            .fullScreenCover(isPresented: $isNewlyCreatedWorkout) {
                //let newWorkout = viewModel.createNewWorkout(userId: user.id)
                NavigationStack {
                    WorkoutTemplateDetailView(
                        viewModel: WorkoutTemplateDetailViewModel(workout: newWorkout, newlyCreated: true){ updatedWorkout in
                            viewModel.updateWorkout(updatedWorkout)
                            // TODO: Must change this: the below line will keep adding another workout to the viewModel list every time the Save button is tapped!
                            viewModel.templateWorkoutsForUser.append(updatedWorkout)
                        }
                    )
                }
            }
            
            
            // WorkoutTemplateList
            if selectedLibrary == .saved {
                if viewModel.isLoadingWorkoutsForUser {
                    ProgressView()
                        .task {
                            await viewModel.loadAllTemplateWorkoutsForUser(uid: user.id)
                        }
                    Spacer()
                } else {
                    List {
                        //ForEach(WorkoutTemplate.MOCK_WORKOUTS) { workout in
                        ForEach(viewModel.templateWorkoutsForUser) { workout in
                            NavigationLink(value: workout) {
                                VStack {
                                    // TODO: Update XSmallUserView to use userId not user since workouts will no longer have users, or else maybe they should have a small amount of info under the user property. Hmm...
                                    if let user = workout.user {
                                        XSmallUserView(user: user)
                                    }
                                    TemplateWorkoutSummaryView(workout: workout)
                                }
                            }
                        }
                        .onDelete(perform: viewModel.deleteWorkout)
                    }
                    .listStyle(.inset)
                    .navigationDestination(for: WorkoutTemplate.self) { workout in
                        //WorkoutTemplateDetailView(workout: workout)
                        WorkoutTemplateDetailView(
                            viewModel: WorkoutTemplateDetailViewModel(workout: workout) { updatedWorkout in
                                viewModel.updateWorkout(updatedWorkout)
                            }
                        )
                    }
                }
                //.padding()
            } else if selectedLibrary == .community {
                if viewModel.isLoadingWorkoutsExcludingUser {
                    ProgressView()
                        .task {
                            await viewModel.loadAllTemplateWorkoutsExcludingUser(uid: user.id)
                        }
                    Spacer()
                } else {
                    List {
                        //ForEach(WorkoutTemplate.MOCK_WORKOUTS) { workout in
                        ForEach(viewModel.templateWorkoutsExcludingUser) { workout in
                            NavigationLink(value: workout) {
                                VStack {
                                    if let user = workout.user {
                                        XSmallUserView(user: user)
                                    }
                                    TemplateWorkoutSummaryView(workout: workout)
                                }
                            }
                        }
                    }
                    .listStyle(.inset)
                    .navigationDestination(for: WorkoutTemplate.self) { workout in
                        WorkoutTemplateDetailView(viewModel: WorkoutTemplateDetailViewModel(workout: workout))
                    }
                }
                
            }
        }
        
    }
}

#Preview {
    
    WorkoutLibraryView(user: User.MOCK_USERS[0])
}
