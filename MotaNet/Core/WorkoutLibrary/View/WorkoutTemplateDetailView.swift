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
    @State var newWorkoutName: String
    @State private var supersetAdded = false
    @State var workoutChangedAlertPresented = false
    @State private var toast: Toast? = nil
    @Environment(\.dismiss) private var dismiss
    
    init(viewModel: WorkoutTemplateDetailViewModel) {
        self._viewModel = State(initialValue: viewModel)
        self._newWorkoutName = State(initialValue: viewModel.workout.name)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if viewModel.workout.supersets.isEmpty {
                ContentUnavailableView {
                    Label("Empty workout", systemImage: "figure.run")
                } description: {
                    Text("Add exercises by tapping the + button.")
                }
            } else {
                List {
                    ForEach(viewModel.workout.supersets) {superset in
                        NavigationLink(value: superset) {
                            SupersetSummaryView(superset: superset)
                        }
                        
                    }
                    .onDelete(perform: viewModel.removeSuperset)
                    .onMove(perform: viewModel.moveSuperset)
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
            
        }
        .navigationTitle(viewModel.workout.name)
        .navigationBarTitleDisplayMode(.inline)
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
        .navigationDestination(for: Superset.self) { superset in
            SupersetDetailView(superset: superset)
        }
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
        .alert("Add to workout history?", isPresented: $addToLog) {
            Button("OK"){
                viewModel.addWorkoutToLog()
                toast = Toast(style: .success, message: "Workout added to history.")
            }
            Button("Cancel", role: .cancel) {
                
            }
        }
        .alert("Rename your workout", isPresented: $viewModel.newlyCreated) {
            TextField("Reps...", text: $newWorkoutName)
                .keyboardType(.numberPad)
                .font(.footnote)
            Button("OK"){
                // update workout name
                viewModel.renameWorkout(newWorkoutName)
                viewModel.newlyCreated = false
            }
        }
        .toastView(toast: $toast)
        .onChange(of: supersetAdded) { oldValue, newValue in
            if newValue {
                viewModel.isWorkoutEditted = true
                supersetAdded = false
            }
        }
    }
}

#Preview {
    NavigationStack {
        WorkoutTemplateDetailView(viewModel: WorkoutTemplateDetailViewModel(workout: WorkoutTemplate.MOCK_WORKOUTS[1]))
    }
}
