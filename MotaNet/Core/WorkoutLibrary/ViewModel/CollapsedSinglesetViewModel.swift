//
//  CollapsedSinglesetViewModel.swift
//  MotaNet
//
//  Created by sam hastings on 24/09/2024.
//

import Foundation

@Observable
class CollapsedSinglesetViewModel {
    var collapsedSingleset: CollapsedSingleset
    
    init(collapsedSingleset: CollapsedSingleset) {
        self.collapsedSingleset = collapsedSingleset
    }
    
    var imageUrls: [String] { collapsedSingleset.exerciseImageUrls }
    var exerciseName: String { collapsedSingleset.exerciseName }
    var reps: Int? {
        get { collapsedSingleset.reps }
        set { collapsedSingleset.reps = newValue ?? 0 }
    }
    var weight: Int? {
        get { collapsedSingleset.weight }
        set { collapsedSingleset.weight = newValue ?? 0 }
    }
    
}
