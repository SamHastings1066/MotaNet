//
//  SupersetSummaryViewModel.swift
//  MotaNet
//
//  Created by sam hastings on 10/08/2024.
//

import Foundation

@Observable
class SupersetSummaryViewModel {
    let superset: Superset
    
    init(superset: Superset) {
        self.superset = superset
    }
    
//    var uniqueExercises: [Exercise] {
//        superset.rounds[0].singlesets.map{ $0.exercise}
//    }
    
    var exerciseSummaries: [ExerciseSummary] {
        let exerciseCount = superset.rounds[0].singlesets.count
        var summaries = [ExerciseSummary]()
        for exerciseIdx in 0..<exerciseCount {
            let firstRoundReps = superset.rounds[0].singlesets[exerciseIdx].reps
            let firstRoundWeight = superset.rounds[0].singlesets[exerciseIdx].weight
            let consistentReps = superset.rounds.allSatisfy{$0.singlesets[exerciseIdx].reps == firstRoundReps} ? firstRoundReps : nil
            let consistentWeight = superset.rounds.allSatisfy{$0.singlesets[exerciseIdx].weight == firstRoundWeight} ? firstRoundWeight : nil
            summaries.append(ExerciseSummary(
                exercise: superset.rounds[0].singlesets[exerciseIdx].exercise,
                consistentReps: consistentReps,
                consistentWeight: consistentWeight
            ))
        }
        return summaries
    }
    
    var consistentRest: Int? {
        let firstRoundRest = superset.rounds[0].rest
        return superset.rounds.allSatisfy{$0.rest == firstRoundRest} ? firstRoundRest : nil
    }
    
    var numRounds: Int {
        superset.rounds.count
    }
}

struct ExerciseSummary: Identifiable {
    let id = UUID()
    var exercise: Exercise
    var consistentReps: Int?
    var consistentWeight: Int?
}
