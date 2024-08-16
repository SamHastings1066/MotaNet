//
//  AddExerciseView.swift
//  MotaNet
//
//  Created by sam hastings on 12/08/2024.
//

import SwiftUI
import SwiftData

struct AddExerciseView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @State private var exercises: [Exercise] = []
    @Binding var workout: WorkoutTemplate
    @State private var exerciseToAdd: Exercise?
    @State private var showAlert = false
    @State private var reps = ""
    @State private var weight = ""
    @State private var currentPage: Int = 0
    let pageLength = 15
    
    func addSuperset(exercise: Exercise) {
        do {
            let weightInt: Int = Int(weight) ?? 0
            let repsInt: Int = Int(reps) ?? 0
            workout.supersets.append( try Superset(rounds: Array(repeating: Round(singlesets: [Singleset(exercise: exercise, weight: weightInt, reps: repsInt)], rest: 60), count: 3)))
        } catch {
            print("Error adding superset: \(error.localizedDescription)")
        }
    }
    
    private func fetchExerciseIfNecessary(exercise: Exercise) {
        if let lastExercise = exercises.last, lastExercise == exercise {
            currentPage += 1
            performFetch(currentPage: currentPage)
        }
    }
    
    private func performFetch(currentPage: Int) {
        var fetchDescriptor = FetchDescriptor<Exercise>()
        fetchDescriptor.fetchLimit = pageLength
        fetchDescriptor.fetchOffset = currentPage * pageLength
        fetchDescriptor.sortBy = [.init(\.name, order: .forward)]
        
        do {
            self.exercises += try context.fetch(fetchDescriptor)
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        List {
            //ForEach(Exercise.MOCK_EXERCISES) { exercise in
            ForEach(exercises) { exercise in
                ExerciseRowView(exercise: exercise)
                    .onTapGesture {
                        exerciseToAdd = exercise
                        showAlert = true
                        //dismiss()
                    }
                    .onAppear {
                        fetchExerciseIfNecessary(exercise: exercise)
                    }
            }
        }
        .onAppear {
            performFetch(currentPage: currentPage)
        }
        .alert("Add superset",
               isPresented: $showAlert,
               presenting: exerciseToAdd
        ) { exercise in
            
            TextField("Reps...", text: $reps)
                .keyboardType(.numberPad)
                .font(.footnote)
            TextField("Weight...", text: $weight)
                .keyboardType(.numberPad)
                .font(.footnote)
            
            
            Button("OK") {
                addSuperset(exercise: exercise)
                dismiss()
            }
            Button("Cancel", role: .cancel) {}
        } message: { exercise in
            VStack {
                Text("\(exercise.name): please specify the number of reps and the weight.")
            }
        }
    }
}

#Preview { //@MainActor in
    return AddExerciseView(workout: .constant(WorkoutTemplate.MOCK_WORKOUTS[0])).modelContainer(SwiftDataManager.shared.container)
}
