//
//  SinglesetViewModel.swift
//  MotaNet
//
//  Created by sam hastings on 24/09/2024.
//

import Foundation

@Observable
class SinglesetViewModel {
    
    let singleset: Singleset
    
    init(singleset: Singleset) {
        self.singleset = singleset
    }
    
    var imageUrls: [String] { singleset.exerciseImageUrls }
    var exerciseName: String { singleset.exerciseName }
    var reps: Int? {
        get { singleset.reps }
        set { singleset.reps = newValue ?? 0 }
    }
    var weight: Int? {
        get { singleset.weight }
        set { singleset.weight = newValue ?? 0 }
    }
    
}
