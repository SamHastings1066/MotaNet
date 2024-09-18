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
                    
                    
                    exerciseNames.insert(singleset.exerciseName)
                    
                    for primaryMuscle in singleset.primaryMuscles {
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

/// A `Workout` is a collection of supersets.
protocol Workout: Identifiable, Sendable, Codable {
    var id: String { get }
    var ownerId: String { get }
    var name: String { get set }
    var supersets: [Superset] { get set }
    var startTime: Date { get set }
    var user: User? { get set }
    var userId: String? { get set }
}

@Observable
final class WorkoutTemplate: Workout, Hashable {
    
    static func == (lhs: WorkoutTemplate, rhs: WorkoutTemplate) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id = UUID().uuidString
    var ownerId = UUID().uuidString
    var name: String
    var supersets: [Superset]
    var startTime: Date = Date()
    var user: User?
    var userId: String?
    var lastUpdated: Date = Date()
    
    init(id: String = UUID().uuidString, ownerId: String = UUID().uuidString, name: String, supersets: [Superset], startTime: Date = Date(), user: User? = nil, userId: String? = nil, lastUpdated: Date = Date()) {
        self.id = id
        self.ownerId = ownerId
        self.name = name
        self.supersets = supersets
        self.startTime = startTime
        self.user = user
        self.userId = userId
        self.lastUpdated = lastUpdated
    }
    
}

extension WorkoutTemplate {
    static var MOCK_WORKOUTS: [WorkoutTemplate]  {
        var mockWorkouts = [WorkoutTemplate]()
        do {
            let lowerBodyVolume = WorkoutTemplate(
                name: "Lower body volume",
                supersets: [
                    try Superset(
                        rounds: [ Round(singlesets: [Singleset(timestamp: Date(), weight: 60, reps: 11, exerciseId: "Barbell_Squat", exerciseName: "Barbell Squat", exerciseImageUrls: ["Barbell_Squat/0.jpg", "Barbell_Squat/1.jpg"], primaryMuscles: [.quadriceps])], rest: 120)]
                    ),
                    try Superset(
                        rounds: [ Round(singlesets: [Singleset(timestamp: Date(), weight: 80, reps: 10, exerciseId: "Barbell_Deadlift", exerciseName: "Barbell Deadlift", exerciseImageUrls: ["Barbell_Deadlift/0.jpg", "Barbell_Deadlift/1.jpg"], primaryMuscles: [.glutes, .quadriceps])], rest: 120)]
                    )
                ],
                startTime: Date(),
                user: User.MOCK_USERS[0],
                userId: "kNGoA7iAzxbWxlztKNUF4ojsN6v2",
                lastUpdated: Date()
            )
            mockWorkouts.append(lowerBodyVolume)
            
            let upperBodyVolume = WorkoutTemplate(
                name: "Upper body volume",
                supersets: [
                    try Superset(
                        rounds: [Round(singlesets: [
                            Singleset(timestamp: Date(), weight: 70, reps: 14, exerciseId: "Dumbbell_Bench_Press", exerciseName: "Dumbbell Bench Press", exerciseImageUrls: ["Dumbbell_Bench_Press/0.jpg", "Dumbbell_Bench_Press/1.jpg"], primaryMuscles: [.quadriceps]),
                            Singleset(timestamp: Date(), weight: 75, reps: 14, exerciseId: "Seated_Cable_Rows", exerciseName: "Seated Cable Rows", exerciseImageUrls: ["Seated_Cable_Rows/0.jpg", "Seated_Cable_Rows/1.jpg"], primaryMuscles: [.quadriceps])
                        ], rest: 90)]
                    ),
                    try Superset(
                        rounds: [ Round(singlesets: [
                            Singleset(timestamp: Date(), weight: 80, reps: 11, exerciseId: "Wide-Grip_Lat_Pulldown", exerciseName: "Wide-Grip Lat Pulldown", exerciseImageUrls: ["Wide-Grip_Lat_Pulldown/0.jpg", "Wide-Grip_Lat_Pulldown/1.jpg"], primaryMuscles: [.quadriceps]),
                            Singleset(timestamp: Date(), weight: 55, reps: 10, exerciseId: "Dumbbell_Shoulder_Press", exerciseName: "Dumbbell Shoulder Press", exerciseImageUrls: ["Dumbbell_Shoulder_Press/0.jpg", "Dumbbell_Shoulder_Press/1.jpg"], primaryMuscles: [.quadriceps])
                        ], rest: 120)]
                    )
                ],
                startTime: Date(),
                user: User.MOCK_USERS[0],
                lastUpdated: Date()
            )
            mockWorkouts.append(upperBodyVolume)
        } catch {
            print("Error creating mock workout \(error)")
        }
        return mockWorkouts
    }
}

@Observable
final class WorkoutCompleted: Workout, Hashable {
    static func == (lhs: WorkoutCompleted, rhs: WorkoutCompleted) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id = UUID().uuidString
    var ownerId = UUID().uuidString
    var name: String
    var supersets: [Superset]
    var startTime: Date = Date()
    var user: User?
    var caption: String = ""
    var likes: Int = 0
    var userId: String?
    
    init(id: String = UUID().uuidString, ownerId: String = UUID().uuidString, name: String, supersets: [Superset], startTime: Date = Date(), user: User? = nil, caption: String, likes: Int, userId: String? = nil) {
        self.id = id
        self.ownerId = ownerId
        self.name = name
        self.supersets = supersets
        self.startTime = startTime
        self.user = user
        self.caption = caption
        self.likes = likes
        self.userId = userId
    }
}

extension WorkoutCompleted {
    /// Creates a `WorkoutCompleted` object from a `WorkoutTemplate`.
    /// - Parameter template: The `WorkoutTemplate` object to copy data from.
    /// - Returns: A new `WorkoutCompleted` object with values copied from the `WorkoutTemplate`.
    static func from(template: WorkoutTemplate) -> WorkoutCompleted {
        WorkoutCompleted(
            id: UUID().uuidString,              // Generates a new UUID to differentiate the completed workout.
            ownerId: template.ownerId,
            name: template.name,
            supersets: template.supersets,
            startTime: Date(),                  // Sets the start time to the current time.
            user: template.user,
            caption: "",                        // Set default values for `caption` and `likes`.
            likes: 0,
            userId: template.userId
        )
    }
}

extension WorkoutCompleted {
    static var MOCK_WORKOUTS: [WorkoutCompleted] {
        var mockWorkouts = [WorkoutCompleted]()
        do {
            let lowerBodyVolume = WorkoutCompleted(
                name: "Lower body volume",
                supersets: [
                    try Superset(
                        rounds: [Round(singlesets: [Singleset(timestamp: Date(), weight: 60, reps: 11, exerciseId: "Barbell_Squat", exerciseName: "Barbell Squat", exerciseImageUrls: ["Barbell_Squat/0.jpg", "Barbell_Squat/1.jpg"], primaryMuscles: [.quadriceps])], rest: 120)]
                    ),
                    try Superset(
                        rounds: [Round(singlesets: [Singleset(timestamp: Date(), weight: 80, reps: 10, exerciseId: "Barbell_Deadlift", exerciseName: "Barbell Deadlift", exerciseImageUrls: ["Barbell_Deadlift/0.jpg", "Barbell_Deadlift/1.jpg"], primaryMuscles: [.glutes, .quadriceps])], rest: 120)]
                    )
                ],
                startTime: Date(),
                user: User.MOCK_USERS[0],
                caption: "Light work.",
                likes: 476,
                userId: "kNGoA7iAzxbWxlztKNUF4ojsN6v2"
            )
            mockWorkouts.append(lowerBodyVolume)
            
            let upperBodyVolume = WorkoutCompleted(
                name: "Upper body volume",
                supersets: [
                    try Superset(
                        rounds: [Round(singlesets: [
                            Singleset(timestamp: Date(), weight: 70, reps: 20, exerciseId: "Dumbbell_Bench_Press", exerciseName: "Dumbbell Bench Press", exerciseImageUrls: ["Dumbbell_Bench_Press/0.jpg", "Dumbbell_Bench_Press/1.jpg"], primaryMuscles: [.quadriceps]),
                            Singleset(timestamp: Date(), weight: 75, reps: 14, exerciseId: "Seated_Cable_Rows", exerciseName: "Seated Cable Rows", exerciseImageUrls: ["Seated_Cable_Rows/0.jpg", "Seated_Cable_Rows/1.jpg"], primaryMuscles: [.quadriceps])
                        ], rest: 90)]
                    ),
                    try Superset(
                        rounds: [Round(singlesets: [
                            Singleset(timestamp: Date(), weight: 80, reps: 11, exerciseId: "Wide-Grip_Lat_Pulldown", exerciseName: "Wide-Grip Lat Pulldown", exerciseImageUrls: ["Wide-Grip_Lat_Pulldown/0.jpg", "Wide-Grip_Lat_Pulldown/1.jpg"], primaryMuscles: [.quadriceps]),
                            Singleset(timestamp: Date(), weight: 55, reps: 10, exerciseId: "Dumbbell_Shoulder_Press", exerciseName: "Dumbbell Shoulder Press", exerciseImageUrls: ["Dumbbell_Shoulder_Press/0.jpg", "Dumbbell_Shoulder_Press/1.jpg"], primaryMuscles: [.quadriceps])
                        ], rest: 120)]
                    )
                ],
                startTime: Date(),
                user: User.MOCK_USERS[0],
                caption: "Exhausted!",
                likes: 476
            )
            mockWorkouts.append(upperBodyVolume)
        } catch {
            print("Error creating mock workout \(error)")
        }
        return mockWorkouts
    }
}

/// `SuperSet` is a collection of  rounds.
struct Superset: Sendable, Identifiable, Hashable, Codable {
    
    static func == (lhs: Superset, rhs: Superset) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id = UUID().uuidString
    var timestamp: Date = Date()
    var rounds: [Round] = []
    //    var orderedRounds: [Round] {
    //        rounds.sorted{$0.timestamp < $1.timestamp}
    //    }
    
    init(rounds: [Round]) throws {
        guard Superset.validateRounds(rounds) else {
            throw SupersetError.invalidRounds
        }
        self.rounds = rounds
    }
    
    /// Ensures that all rounds in a superset contain the same exercises in the same order.
    static func validateRounds(_ rounds: [Round]) -> Bool {
        guard let firstRound = rounds.first else { return true }
        
        let firstRoundExercises = firstRound.singlesets.map { $0.exerciseId }
        
        for round in rounds {
            let roundExercises = round.singlesets.map { $0.exerciseId }
            if roundExercises != firstRoundExercises {
                return false
            }
        }
        return true
    }
    
    enum SupersetError: Error {
        case invalidRounds
    }
    
    
}

extension Superset {
    static func createSuperset(numRounds: Int, exercise: Exercise, weight: Int = 0, reps: Int = 0, rest: Int = 60) throws -> Superset {
        var rounds: [Round] = []
        for _ in 0..<numRounds {
            let singleset = Singleset(exercise: exercise, weight: weight, reps: reps, id: UUID().uuidString)
            let round = Round(id: UUID().uuidString,singlesets: [singleset], rest: rest)
            rounds.append(round)
        }
        return try Superset(rounds: rounds)
    }
}

/// `Round` is a collection of singlesets.
struct Round: Sendable, Identifiable, Codable {
    var id = UUID().uuidString
    var timestamp: Date = Date()
    var singlesets: [Singleset] = []
    var rest: Int = 0
    
}

/// `SingleSet` is the smallest component of a workout. It comprises the exercise being undertaken as well as the parameters of that exercise e.g. weight, repetitions.
struct Singleset: Sendable, Identifiable, Codable {
    var id = UUID().uuidString
    var timestamp: Date = Date()
    //var exercise: Exercise
    var weight: Int = 0
    var reps: Int = 0
    var exerciseId: String
    var exerciseName: String
    var exerciseImageUrls: [String]
    var primaryMuscles: [Exercise.Muscle]
    
    init(timestamp: Date, weight: Int, reps: Int, exerciseId: String, exerciseName: String, exerciseImageUrls: [String], primaryMuscles: [Exercise.Muscle]) {
        self.timestamp = timestamp
        self.weight = weight
        self.reps = reps
        self.exerciseId = exerciseId
        self.exerciseName = exerciseName
        self.exerciseImageUrls = exerciseImageUrls
        self.primaryMuscles = primaryMuscles
    }
    
    init(timestamp: Date = Date(), exercise: Exercise, weight: Int, reps: Int, id: String = UUID().uuidString) {
        self.timestamp = timestamp
        self.weight = weight
        self.reps = reps
        self.exerciseId = exercise.id
        self.exerciseName = exercise.name
        self.exerciseImageUrls = exercise.images
        self.primaryMuscles = exercise.primaryMuscles
    }
    
    
    
}
