//
//  MotaNetTests.swift
//  MotaNetTests
//
//  Created by sam hastings on 08/08/2024.
//

import XCTest
@testable import MotaNet

final class SupersetTests: XCTestCase {
    func test_roundsWithDifferentExerciseOrderAreNotValidSuperset() throws {
        let exercise1 = Exercise.MOCK_EXERCISES[0]
        let exercise2 = Exercise.MOCK_EXERCISES[1]
        let round1 = Round (
            singlesets: [
                Singleset(exercise: exercise1 , weight: 10, reps: 100),
                Singleset(exercise: exercise2 , weight: 12, reps: 90)
            ]
        )
        let round2 = Round (
            singlesets: [
                Singleset(exercise: exercise2 , weight: 10, reps: 100),
                Singleset(exercise: exercise1 , weight: 12, reps: 90)
            ]
        )
        
        XCTAssertFalse(Superset.validateRounds([round1, round2]))
        
    }
   

}
