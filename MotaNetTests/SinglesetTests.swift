//
//  SinglesetTests.swift
//  MotaNetTests
//
//  Created by sam hastings on 01/10/2024.
//

import XCTest
@testable import MotaNet

final class SinglesetTests: XCTestCase {
    
    var barbellSquat: Exercise!
    
    override func setUp()  {
        super.setUp()
        barbellSquat = Exercise.MOCK_EXERCISES[0]
    }

    override func tearDown()  {
        barbellSquat = nil
        super.tearDown()
    }

    func test_init_withExercise_shouldCreateSupersetWithExerciseIdNameImagesAndPrimaryMuscles() {
        //Arrange
        
        //Act
        let sut = Singleset(exercise: barbellSquat, weight: 0, reps: 0)
        
        //Assert
        XCTAssertEqual(sut.exerciseId, barbellSquat.id)
        XCTAssertEqual(sut.exerciseName, barbellSquat.name)
        XCTAssertEqual(sut.exerciseImageUrls, barbellSquat.images)
        XCTAssertEqual(sut.primaryMuscles, barbellSquat.primaryMuscles)
    }

}
