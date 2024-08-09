//
//  Workout.swift
//  MotaNet
//
//  Created by sam hastings on 08/08/2024.
//

import Foundation

struct WorkoutStats {
    let totalReps: Int
    let totalVolume: Int
    let musclesUsed: [String: Int]
    let uniqueExerciseNames: Set<String>
    
    static func compute(from workout: any Workout) -> WorkoutStats {
        var totalReps = 0
        var totalVolume = 0
        var muscleUsageDict = [String: Int]()
        var exerciseNames: Set<String> = []
        
        for superset in workout.supersets {
            for round in superset.rounds {
                for singleset in round.singlesets {
                    totalReps += singleset.reps
                    totalVolume += singleset.reps * singleset.weight
                    
                    
                    exerciseNames.insert(singleset.exercise.name)
                    
                    for primaryMuscle in singleset.exercise.primaryMuscles {
                        muscleUsageDict[primaryMuscle.rawValue, default: 0] += singleset.reps * singleset.weight
                    }
                    //                        for secondaryMuscle in singleset.exercise.secondaryMuscles {
                    //                            muscleUsageDict[secondaryMuscle.rawValue, default: 0] += singleset.reps * singleset.weight
                    //                        }
                    
                }
            }
        }
        
        return WorkoutStats(
            totalReps: totalReps,
            totalVolume: totalVolume,
            musclesUsed: muscleUsageDict,
            uniqueExerciseNames: exerciseNames
        )
    }
}

protocol Workout: Identifiable, Sendable {
    var id: String { get }
    var ownerId: String { get }
    var name: String { get set }
    var supersets: [Superset] { get set }
    var startTime: Date { get set }
    var user: User? { get set }
}

struct WorkoutTemplate: Workout {
    let id = UUID().uuidString
    let ownerId = UUID().uuidString
    var name: String
    var supersets: [Superset]
    var startTime: Date = Date()
    var user: User?
}


struct WorkoutCompleted: Workout {
    let id = UUID().uuidString
    let ownerId = UUID().uuidString
    var name: String
    var supersets: [Superset]
    var startTime: Date = Date()
    var endTime: Date
    var user: User?
    var caption: String = ""
    var likes: Int = 0
}

extension WorkoutCompleted {
    static var MOCK_WORKOUTS: [WorkoutCompleted] = [
        WorkoutCompleted(
            name: "Lower body volume",
            supersets: [
                Superset(
                    rounds: Array(repeating: Round(singlesets: [Singleset(exercise: Exercise.MOCK_EXERCISES[0], weight: 60, reps: 11)], rest: 120), count: 10)
                ),
                Superset(
                    rounds: Array(repeating: Round(singlesets: [Singleset(exercise: Exercise.MOCK_EXERCISES[1], weight: 80, reps: 10)], rest: 120), count: 8)
                )
            ],
            startTime: Date(),
            endTime: Date().addingTimeInterval(TimeInterval(1)),
            user: User.MOCK_USERS[0],
            caption: "Light work.",
            likes: 476
            
        ),
        WorkoutCompleted(
            name: "Upper body volume",
            supersets: [
                Superset(
                    rounds: Array(repeating: Round(singlesets: [
                        Singleset(exercise: Exercise.MOCK_EXERCISES[2], weight: 70, reps: 14),
                        Singleset(exercise: Exercise.MOCK_EXERCISES[3], weight: 75, reps: 14)
                    ], rest: 90), count: 8)
                ),
                Superset(
                    rounds: Array(repeating: Round(singlesets: [
                        Singleset(exercise: Exercise.MOCK_EXERCISES[4], weight: 80, reps: 11),
                        Singleset(exercise: Exercise.MOCK_EXERCISES[5], weight: 55, reps: 10)
                    ], rest: 120), count: 8)
                )
            ],
            startTime: Date(),
            endTime: Date().addingTimeInterval(TimeInterval(1)),
            user: User.MOCK_USERS[0],
            caption: "Exhausted!",
            likes: 476
        )
    ]
}


struct Superset: Sendable {
    var timestamp: Date = Date()
    var rounds: [Round] = []
    var orderedRounds: [Round] {
        rounds.sorted{$0.timestamp < $1.timestamp}
    }
    
    
}

struct Round: Sendable {
    let timestamp: Date = Date()
    var singlesets: [Singleset] = []
    var rest: Int = 0
    
}


struct Singleset: Sendable {
    var timestamp: Date = Date()
    var exercise: Exercise
    var weight: Int = 0
    var reps: Int = 0
    
}
