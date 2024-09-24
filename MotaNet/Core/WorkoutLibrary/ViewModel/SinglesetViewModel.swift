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
    var reps: Int? { singleset.reps }
    var weight: Int? { singleset.weight }
    
}
