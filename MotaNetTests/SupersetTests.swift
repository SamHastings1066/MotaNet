//
//  MotaNetTests.swift
//  MotaNetTests
//
//  Created by sam hastings on 08/08/2024.
//

import XCTest
@testable import MotaNet

final class SupersetTests: XCTestCase {
    var exerciseOne: Exercise!
    var exerciseTwo: Exercise!
    
    override func setUp() {
        super.setUp()
        exerciseOne = Exercise.MOCK_EXERCISES[0]
        exerciseTwo = Exercise.MOCK_EXERCISES[1]
    }
    
    override func tearDown() {
        exerciseOne = nil
        exerciseTwo = nil
        super.tearDown()
    }
    
    func test_validateRounds_withDifferentExerciseOrder_shouldReturnFalse() throws {
        let round1 = Round (
            singlesets: [
                Singleset(exercise: exerciseOne , weight: 10, reps: 100),
                Singleset(exercise: exerciseTwo , weight: 12, reps: 90)
            ]
        )
        let round2 = Round (
            singlesets: [
                Singleset(exercise: exerciseTwo , weight: 10, reps: 100),
                Singleset(exercise: exerciseOne , weight: 12, reps: 90)
            ]
        )
        
        XCTAssertFalse(Superset.validateRounds([round1, round2]))
        
    }
    
    func test_validateRounds_withSameExerciseOrder_shouldReturnTrue() throws {
        let round1 = Round (
            singlesets: [
                Singleset(exercise: exerciseOne , weight: 10, reps: 100),
                Singleset(exercise: exerciseTwo , weight: 12, reps: 90)
            ]
        )
        let round2 = Round (
            singlesets: [
                Singleset(exercise: exerciseOne , weight: 11, reps: 100),
                Singleset(exercise: exerciseTwo , weight: 12, reps: 90)
            ]
        )
        
        XCTAssertTrue(Superset.validateRounds([round1, round2]))
        
    }
    
    func test_validateRounds_withEmptyRounds_shouldReturnTrue() throws {
        XCTAssertTrue(Superset.validateRounds([]))
        
    }
    
    func test_createSuperset_withNumRoundsEqualTo2_shouldCreateSupersetWithTwoRoundsAndEachRoundHasAUniqueId() throws {
        let superset = try Superset.createSuperset(numRounds: 2, exercise: exerciseOne)
        XCTAssertEqual(superset.rounds.count, 2)
        XCTAssertNotEqual(superset.rounds[0].id, superset.rounds[1].id)
    }
   
    func test_createSuperset_withNumRoundsEqualTo0_shouldCreateSupersetWithEmptyRounds() throws {
        let superset = try Superset.createSuperset(numRounds: 0, exercise: exerciseOne)
        XCTAssertEqual(superset.rounds.count, 0)
        
    }

}
