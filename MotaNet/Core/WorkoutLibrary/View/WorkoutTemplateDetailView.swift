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
    @State private var supersetAdded = false
    @State var workoutChangedAlertPresented = false
    @Environment(\.dismiss) private var dismiss
    
    init(viewModel: WorkoutTemplateDetailViewModel) {
        self._viewModel = State(initialValue: viewModel)
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
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Button("Save") {
                            viewModel.saveWorkout()
                        }
                        .disabled(!viewModel.isWorkoutEditted)
                        EditButton()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Back", systemImage: "chevron.left") {
                        viewModel.isWorkoutEditted ? workoutChangedAlertPresented = true : dismiss()
                    }
                }
                
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
                AddExerciseView(workout: $viewModel.workout, supersetAdded: $supersetAdded)
            })
            .alert("Leave screen without saving changes?", isPresented: $workoutChangedAlertPresented) {
                Button("OK"){
                    dismiss()
                }
                Button("Cancel", role: .cancel) {
                    
                }
            }
            .onChange(of: supersetAdded) { oldValue, newValue in
                if newValue {
                    viewModel.isWorkoutEditted = true
                    supersetAdded = false
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        WorkoutTemplateDetailView(viewModel: WorkoutTemplateDetailViewModel(workout: WorkoutTemplate.MOCK_WORKOUTS[1]))
    }
}
