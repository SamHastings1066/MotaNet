//
//  WorkoutTemplateDetailView.swift
//  MotaNet
//
//  Created by sam hastings on 10/08/2024.
//

import SwiftUI

struct WorkoutTemplateDetailView: View {
    
    @State var viewModel: WorkoutTemplateDetailViewModel
    @State var isAddExercisePresented = false
    @State var addToLog = false
    
    init(workout: WorkoutTemplate) {
        
        self._viewModel = State(initialValue: WorkoutTemplateDetailViewModel(workout: workout))
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            List {
                ForEach(viewModel.workout.supersets) {superset in
                    NavigationLink(value: superset) {
                        SupersetSummaryView(superset: superset)
                    }
                    
                }
                .onDelete(perform: viewModel.removeSuperset)
                .onMove(perform: viewModel.moveSuperset)
            }
            .navigationTitle(viewModel.workout.name)
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Superset.self) { superset in
                SupersetDetailView(superset: superset)
            }
            .toolbar {
                EditButton()
            }
            HStack {
                Button {
                    isAddExercisePresented = true
                } label: {
                    Image(systemName: "plus")
                        .font(.headline.weight(.semibold))
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 4, x: 0, y: 4)
                }
                Button {
                    addToLog = true
                } label: {
                    Text("Add to log")
                        .font(.headline.weight(.semibold))
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                        .shadow(radius: 4, x: 0, y: 4)
                }
            }
            .padding()
            .popover(isPresented: $isAddExercisePresented, content: {
                AddExerciseView(workout: $viewModel.workout)
            })

        }
    }
}

#Preview {
    NavigationStack {
        WorkoutTemplateDetailView(workout: WorkoutTemplate.MOCK_WORKOUTS[1])
    }
}
