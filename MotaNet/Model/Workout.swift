//
//  Workout.swift
//  MotaNet
//
//  Created by sam hastings on 08/08/2024.
//

import Foundation


import Foundation

struct WorkoutStats {
    var totalReps: Int
    var totalVolume: Int
    var musclesUsed: [String: Int]
    var uniqueExercises: [String]
    
    init(totalReps: Int = 0, totalVolume: Int = 0, musclesUsed: [String: Int] = [:], uniqueExercises: [String] = []) {
        self.totalReps = totalReps
        self.totalVolume = totalVolume
        self.musclesUsed = musclesUsed
        self.uniqueExercises = uniqueExercises
    }
}

protocol Workout: Sendable {
    var supersets: [Superset] { get set }
    func computeWorkoutStats() -> WorkoutStats
}

extension Workout {
    
    func computeWorkoutStats() -> WorkoutStats {
            var totalReps = 0
            var totalVolume = 0
            var muscleUsageDict = [String: Int]()
            var exerciseNames: Set<String> = []

            for superset in self.supersets {
                for round in superset.rounds {
                    for singleset in round.singlesets {
                        totalReps += singleset.reps
                        totalVolume += singleset.reps * singleset.weight
                        
                        if let exercise = singleset.exercise {
                            exerciseNames.insert(exercise.name)
                            
                            for primaryMuscle in exercise.primaryMuscles {
                                muscleUsageDict[primaryMuscle.rawValue, default: 0] += singleset.reps * singleset.weight
                            }
    //                        for secondaryMuscle in exercise.secondaryMuscles {
    //                            muscleUsageDict[secondaryMuscle.rawValue, default: 0] += singleset.reps * singleset.weight
    //                        }
                        }
                    }
                }
            }

            return WorkoutStats(totalReps: totalReps, totalVolume: totalVolume, musclesUsed: muscleUsageDict, uniqueExercises: Array(exerciseNames))
        }
    
}



struct WorkoutTemplate: Sendable, Workout {
    let id = NSUUID().uuidString
    var name: String
    let timeStamp: Date
    var supersets: [Superset]
    
    init(name: String = "New Workout", timestamp: Date = Date(), supersets: [Superset] = [] ) {
        self.name = name
        self.timeStamp = timestamp
        self.supersets = supersets
    }
    
    
}

extension WorkoutTemplate {
    
}

struct WorkoutCompleted: Sendable, Workout {
    let id = NSUUID().uuidString
    var name: String
    let timeStamp: Date
    var supersets: [Superset]
    var startTime: Date
    var endTime: Date
    
    
    init(name: String = "Completed Workout", timestamp: Date = Date(), supersets: [Superset] = [], startTime: Date = Date(), endTime: Date = Date()) {
        self.name = name
        self.timeStamp = timestamp
        self.supersets = supersets
        self.startTime = startTime
        self.endTime = endTime
    }
    
    init(workout: WorkoutTemplate, startTime: Date = Date(), endTime: Date = Date()) {
        self.name = workout.name
        self.timeStamp = workout.timeStamp
        self.supersets = workout.supersets
        self.startTime = startTime
        self.endTime = endTime
    }

}


struct Superset: Sendable {
    var timestamp: Date
    var rounds: [Round]
    var orderedRounds: [Round] {
        rounds.sorted{$0.timestamp < $1.timestamp}
    }
    
    init(timestamp: Date = Date(), rounds: [Round] = []) {
        self.timestamp = timestamp
        self.rounds = rounds
    }
    
   
}

struct Round: Sendable {
    let timestamp: Date
    var singlesets: [Singleset]
    var rest: Int
    
    init(timestamp: Date = Date(), singlesets: [Singleset] = [], rest: Int = 0) {
        self.timestamp = timestamp
        self.singlesets = singlesets
        self.rest = rest
    }
    
}


struct Singleset: Sendable {
    var timestamp: Date
    var exercise: Exercise?
    var weight: Int
    var reps: Int
    
    var imageName: String? {
        if !(exercise?.imageURLs.isEmpty ?? false) {
            return exercise?.imageURLs[0]
        } else {
            return nil
        }
    }
    
    init(timestamp: Date = Date(), exercise: Exercise? = Exercise(), weight: Int = 0, reps: Int = 0) {
        self.timestamp = timestamp
        self.exercise = exercise
        self.weight = weight
        self.reps = reps
    }
    
    
}
