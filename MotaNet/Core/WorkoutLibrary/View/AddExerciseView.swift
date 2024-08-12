//
//  AddExerciseView.swift
//  MotaNet
//
//  Created by sam hastings on 12/08/2024.
//

import SwiftUI

struct AddExerciseView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var workout: WorkoutTemplate
    @State private var exerciseToAdd: Exercise?
    @State private var showAlert = false
    @State private var reps = ""
    @State private var weight = ""
    
    func addSuperset(exercise: Exercise) {
        do {
            let weightInt: Int = Int(weight) ?? 0
            let repsInt: Int = Int(reps) ?? 0
            workout.supersets.append( try Superset(rounds: Array(repeating: Round(singlesets: [Singleset(exercise: exercise, weight: weightInt, reps: repsInt)], rest: 60), count: 3)))
        } catch {
            print("Error adding superset: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        List {
            ForEach(Exercise.MOCK_EXERCISES) { exercise in
                ExerciseRowView(exercise: exercise)
                    .onTapGesture {
                        exerciseToAdd = exercise
                        showAlert = true
                        //dismiss()
                    }
            }
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

#Preview {
    AddExerciseView(workout: .constant(WorkoutTemplate.MOCK_WORKOUTS[0]))
}
