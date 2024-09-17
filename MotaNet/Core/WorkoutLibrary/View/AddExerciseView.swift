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
    @Binding var supersetAdded: Bool
    @State private var exerciseToAdd: Exercise?
    @State private var showAlert = false
    @State private var reps = ""
    @State private var weight = ""
    @State private var currentPage: Int = 0
    @State private var searchText = ""
    let pageLength = 15
    
    func addSuperset(exercise: Exercise) {
        do {
            let weightInt: Int = Int(weight) ?? 0
            let repsInt: Int = Int(reps) ?? 0
            
            let newSuperset = try Superset.createSuperset(
                numRounds: 1,
                exercise: exercise,
                weight: weightInt,
                reps: repsInt,
                rest: 60
            )

            workout.supersets.append(newSuperset)
            supersetAdded = true
        } catch {
            print("Error adding superset: \(error.localizedDescription)")
        }
    }
    
    private func fetchExerciseIfNecessary(exercise: Exercise) {
        if let lastExercise = exercises.last, lastExercise == exercise {
            currentPage += 1
            performFetch(currentPage: currentPage, searchText: searchText)
        }
    }
    
    private func performFetch(currentPage: Int, searchText: String) {
        var fetchDescriptor = FetchDescriptor<Exercise>()
        fetchDescriptor.fetchLimit = pageLength
        fetchDescriptor.fetchOffset = currentPage * pageLength
        fetchDescriptor.sortBy = [.init(\.name, order: .forward)]
        
        if !searchText.isEmpty {
            fetchDescriptor.predicate = #Predicate { exercise in
                exercise.name.localizedStandardContains(searchText)
            }
        }
        
        do {
            self.exercises += try context.fetch(fetchDescriptor)
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        NavigationStack{
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
            performFetch(currentPage: currentPage, searchText: searchText)
        }
        .searchable(text: $searchText)
        .onChange(of: searchText, { oldValue, newValue in
            currentPage = 0
            exercises = []
            performFetch(currentPage: currentPage, searchText: newValue)
        })
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
}

#Preview { //@MainActor in
    return AddExerciseView(workout: .constant(WorkoutTemplate.MOCK_WORKOUTS[0]), supersetAdded: .constant(false)).modelContainer(SwiftDataManager.shared.container)
}
