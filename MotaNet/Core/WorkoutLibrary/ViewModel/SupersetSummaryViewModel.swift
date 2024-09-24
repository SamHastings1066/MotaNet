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
    
    var collapsedSinglesets: [CollapsedSingleset] {
        let exerciseCount = superset.rounds[0].singlesets.count
        var summaries = [CollapsedSingleset]()
        for exerciseIdx in 0..<exerciseCount {
            let firstRoundReps = superset.rounds[0].singlesets[exerciseIdx].reps
            let firstRoundWeight = superset.rounds[0].singlesets[exerciseIdx].weight
            let consistentReps = superset.rounds.allSatisfy{$0.singlesets[exerciseIdx].reps == firstRoundReps} ? firstRoundReps : nil
            let consistentWeight = superset.rounds.allSatisfy{$0.singlesets[exerciseIdx].weight == firstRoundWeight} ? firstRoundWeight : nil
            summaries.append(
                CollapsedSingleset(weight: consistentWeight, reps: consistentReps, exerciseName: superset.rounds[0].singlesets[exerciseIdx].exerciseName, exerciseImageUrls: superset.rounds[0].singlesets[exerciseIdx].exerciseImageUrls)
            )
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

struct CollapsedSingleset: Identifiable {
    let id = UUID().uuidString
    var weight: Int?
    var reps: Int?
    let exerciseName: String
    let exerciseImageUrls: [String]
}
