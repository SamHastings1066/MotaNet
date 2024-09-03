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
            
            
            // WorkoutTemplateList
            if selectedLibrary == .saved {
                if viewModel.isLoading {
                    ProgressView()
                        .task {
                            await viewModel.loadAllTemplateWorkouts()
                        }
                } else {
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                            .padding()
                    } else {
                        List {
                            //ForEach(WorkoutTemplate.MOCK_WORKOUTS) { workout in
                            ForEach(viewModel.templateWorkouts) { workout in
                                NavigationLink(value: workout) {
                                    VStack {
                                        if let user = workout.user {
                                            XSmallUserView(user: user)
                                        }
                                        TemplateWorkoutSummaryView(workout: workout)
                                    }
                                }
                            }
                            .onDelete(perform: { indexSet in
                                //
                            })
                        }
                        .listStyle(.inset)
                        .navigationDestination(for: WorkoutTemplate.self) { workout in
                            WorkoutTemplateDetailView(workout: workout)
                        }
                    }
                }
                
                //.padding()
            } else if selectedLibrary == .community {
                if viewModel.isLoading {
                    ProgressView()
                        .task {
                            await viewModel.loadAllTemplateWorkouts()
                        }
                } else {
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                            .padding()
                    } else {
                        List {
                            //ForEach(WorkoutTemplate.MOCK_WORKOUTS) { workout in
                            ForEach(viewModel.templateWorkouts) { workout in
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
                            WorkoutTemplateDetailView(workout: workout)
                        }
                    }
                }
            }
        }
        
        Spacer()
    }
}

#Preview {
    
    WorkoutLibraryView()
}
