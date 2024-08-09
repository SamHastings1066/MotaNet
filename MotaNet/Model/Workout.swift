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
    var name: String { get set }
    var supersets: [Superset] { get set }
    var startTime: Date { get set }
}

struct WorkoutTemplate: Workout {
    let id = UUID().uuidString
    var name: String
    var supersets: [Superset]
    var startTime: Date = Date()
}


struct WorkoutCompleted: Workout {
    let id = UUID().uuidString
    var name: String
    var supersets: [Superset]
    var startTime: Date = Date()
    var endTime: Date?
}

extension WorkoutCompleted {
    static var MOCK_WORKOUTS: [WorkoutCompleted] = [
        WorkoutCompleted(name: "Full body",
                supersets: [
                    Superset(
                        rounds: [
                            Round(singlesets: [Singleset(exercise: Exercise.MOCK_EXERCISES[0], weight: 100, reps: 10), Singleset(exercise: Exercise.MOCK_EXERCISES[1], weight: 90, reps: 15)], rest: 60),
                            Round(singlesets: [Singleset(exercise: Exercise.MOCK_EXERCISES[0], weight: 100, reps: 10), Singleset(exercise: Exercise.MOCK_EXERCISES[1], weight: 90, reps: 15)], rest: 60)
                        ]
                    ),
                    Superset(
                        rounds: [
                            Round(singlesets: [Singleset(exercise: Exercise.MOCK_EXERCISES[2], weight: 100, reps: 20)], rest: 60),
                        ]
                    )
                ]
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
