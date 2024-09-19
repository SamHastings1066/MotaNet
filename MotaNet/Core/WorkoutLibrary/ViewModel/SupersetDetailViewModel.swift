//
//  SupersetDetailViewModel.swift
//  MotaNet
//
//  Created by sam hastings on 19/09/2024.
//

import Foundation

@Observable
class SupersetDetailViewModel {
    let superset: Superset
    
    init(superset: Superset) {
        self.superset = superset
    }
    
    func addRound() {
        superset.addRound()
    }
    
}
