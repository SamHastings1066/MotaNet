//
//  Exercise.swift
//  MotaNet
//
//  Created by sam hastings on 08/08/2024.
//

import Foundation
import SwiftData

@Model
final class Exercise: Codable, Hashable, Identifiable, Sendable {
    
    static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id: String
    var name: String
    var force: Force?
    var level: Level
    var mechanic: Mechanic?
    var equipment: Equipment?
    var primaryMuscles: [Muscle]
    var secondaryMuscles: [Muscle]
    var instructions: [String]
    var category: Category
    var images: [String]
    
    init(id: String, name: String, force: Force?, level: Level, mechanic: Mechanic?, equipment: Equipment?, primaryMuscles: [Muscle], secondaryMuscles: [Muscle], instructions: [String], category: Category, images: [String]) {
        self.id = id
        self.name = name
        self.force = force
        self.level = level
        self.mechanic = mechanic
        self.equipment = equipment
        self.primaryMuscles = primaryMuscles
        self.secondaryMuscles = secondaryMuscles
        self.instructions = instructions
        self.category = category
        self.images = images
    }
    
    convenience init?(data: [String: Any]) {
        guard let id = data["id"] as? String,
              let name = data["name"] as? String,
              let levelString = data["level"] as? String,
              let level = Level(rawValue: levelString),
              let primaryMusclesStrings = data["primaryMuscles"] as? [String],
              let secondaryMusclesStrings = data["secondaryMuscles"] as? [String],
              let instructions = data["instructions"] as? [String],
              let categoryString = data["category"] as? String,
              let category = Category(rawValue: categoryString),
              let images = data["images"] as? [String] else {
            return nil
        }
        
        let force = (data["force"] as? String).flatMap { Force(rawValue: $0) }
        let mechanic = (data["mechanic"] as? String).flatMap { Mechanic(rawValue: $0) }
        let equipment = (data["equipment"] as? String).flatMap { Equipment(rawValue: $0) }
        
        let primaryMuscles = primaryMusclesStrings.compactMap { Muscle(rawValue: $0) }
        let secondaryMuscles = secondaryMusclesStrings.compactMap { Muscle(rawValue: $0) }
        
        self.init(id: id, name: name, force: force, level: level, mechanic: mechanic, equipment: equipment, primaryMuscles: primaryMuscles, secondaryMuscles: secondaryMuscles, instructions: instructions, category: category, images: images)
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.force = try container.decodeIfPresent(Force.self, forKey: .force)
        self.level = try container.decode(Level.self, forKey: .level)
        self.mechanic = try container.decodeIfPresent(Mechanic.self, forKey: .mechanic)
        self.equipment = try container.decodeIfPresent(Equipment.self, forKey: .equipment)
        self.primaryMuscles = try container.decode([Muscle].self, forKey: .primaryMuscles)
        self.secondaryMuscles = try container.decode([Muscle].self, forKey: .secondaryMuscles)
        self.instructions = try container.decode([String].self, forKey: .instructions)
        self.category = try container.decode(Category.self, forKey: .category)
        self.images = try container.decode([String].self, forKey: .images)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(force, forKey: .force)
        try container.encode(level, forKey: .level)
        try container.encode(mechanic, forKey: .mechanic)
        try container.encode(equipment, forKey: .equipment)
        try container.encode(primaryMuscles, forKey: .primaryMuscles)
        try container.encode(secondaryMuscles, forKey: .secondaryMuscles)
        try container.encode(instructions, forKey: .instructions)
        try container.encode(category, forKey: .category)
        try container.encode(images, forKey: .images)
    }
    
    var imageURLs: [String] {
        images.map { imageString in
            imageString.hasSuffix(".jpg") ? String(imageString.dropLast(4)) : imageString }
    }
    
    enum CodingKeys: CodingKey {
        case id, name, force, level, mechanic, equipment, primaryMuscles, secondaryMuscles, instructions, category, images
    }
    
    enum Force: String, Codable {
        case `static`, pull, push
    }
    
    enum Level: String, Codable {
        case beginner, intermediate, expert
    }
    
    enum Mechanic: String, Codable {
        case isolation, compound
    }
    
    enum Equipment: String, Codable {
        case medicineBall = "medicine ball", dumbbell, bodyOnly = "body only", bands, kettlebells, foamRoll = "foam roll", cable, machine, barbell, exerciseBall = "exercise ball", eZCurlBar = "e-z curl bar", other
    }
    
    enum Muscle: String, Codable {
        case abdominals, abductors, adductors, biceps, calves, chest, forearms, glutes, hamstrings, lats, lowerBack = "lower back", middleBack = "middle back", neck, quadriceps, shoulders, traps, triceps
    }
    
    enum Category: String, Codable {
        case powerlifting, strength, stretching, cardio, olympicWeightlifting = "olympic weightlifting", strongman, plyometrics
    }
}

extension Exercise {
    static var MOCK_EXERCISES: [Exercise] {
        let jsonData = """
        [
              {
                "name": "Barbell Squat",
                "force": "push",
                "level": "beginner",
                "mechanic": "compound",
                "equipment": "barbell",
                "primaryMuscles": [
                  "quadriceps"
                ],
                "secondaryMuscles": [
                  "calves",
                  "glutes",
                  "hamstrings",
                  "lower back"
                ],
                "instructions": [
                  "This exercise is best performed inside a squat rack for safety purposes. To begin, first set the bar on a rack to just below shoulder level. Once the correct height is chosen and the bar is loaded, step under the bar and place the back of your shoulders (slightly below the neck) across it.",
                  "Hold on to the bar using both arms at each side and lift it off the rack by first pushing with your legs and at the same time straightening your torso.",
                  "Step away from the rack and position your legs using a shoulder width medium stance with the toes slightly pointed out. Keep your head up at all times and also maintain a straight back. This will be your starting position. (Note: For the purposes of this discussion we will use the medium stance described above which targets overall development; however you can choose any of the three stances discussed in the foot stances section).",
                  "Begin to slowly lower the bar by bending the knees and hips as you maintain a straight posture with the head up. Continue down until the angle between the upper leg and the calves becomes slightly less than 90-degrees. Inhale as you perform this portion of the movement. Tip: If you performed the exercise correctly, the front of the knees should make an imaginary straight line with the toes that is perpendicular to the front. If your knees are past that imaginary line (if they are past your toes) then you are placing undue stress on the knee and the exercise has been performed incorrectly.",
                  "Begin to raise the bar as you exhale by pushing the floor with the heel of your foot as you straighten the legs again and go back to the starting position.",
                  "Repeat for the recommended amount of repetitions."
                ],
                "category": "strength",
                "images": [
                  "Barbell_Squat/0.jpg",
                  "Barbell_Squat/1.jpg"
                ],
                "id": "Barbell_Squat"
              },
                {
                  "name": "Barbell Deadlift",
                  "force": "pull",
                  "level": "intermediate",
                  "mechanic": "compound",
                  "equipment": "barbell",
                  "primaryMuscles": [
                    "lower back"
                  ],
                  "secondaryMuscles": [
                    "calves",
                    "forearms",
                    "glutes",
                    "hamstrings",
                    "lats",
                    "middle back",
                    "quadriceps",
                    "traps"
                  ],
                  "instructions": [
                    "Stand in front of a loaded barbell.",
                    "While keeping the back as straight as possible, bend your knees, bend forward and grasp the bar using a medium (shoulder width) overhand grip. This will be the starting position of the exercise. Tip: If it is difficult to hold on to the bar with this grip, alternate your grip or use wrist straps.",
                    "While holding the bar, start the lift by pushing with your legs while simultaneously getting your torso to the upright position as you breathe out. In the upright position, stick your chest out and contract the back by bringing the shoulder blades back. Think of how the soldiers in the military look when they are in standing in attention.",
                    "Go back to the starting position by bending at the knees while simultaneously leaning the torso forward at the waist while keeping the back straight. When the weights on the bar touch the floor you are back at the starting position and ready to perform another repetition.",
                    "Perform the amount of repetitions prescribed in the program."
                  ],
                  "category": "strength",
                  "images": [
                    "Barbell_Deadlift/0.jpg",
                    "Barbell_Deadlift/1.jpg"
                  ],
                  "id": "Barbell_Deadlift"
                },
                {
                  "name": "Dumbbell Bench Press",
                  "force": "push",
                  "level": "beginner",
                  "mechanic": "compound",
                  "equipment": "dumbbell",
                  "primaryMuscles": [
                    "chest"
                  ],
                  "secondaryMuscles": [
                    "shoulders",
                    "triceps"
                  ],
                  "instructions": [
                    "Lie down on a flat bench with a dumbbell in each hand resting on top of your thighs. The palms of your hands will be facing each other.",
                    "Then, using your thighs to help raise the dumbbells up, lift the dumbbells one at a time so that you can hold them in front of you at shoulder width.",
                    "Once at shoulder width, rotate your wrists forward so that the palms of your hands are facing away from you. The dumbbells should be just to the sides of your chest, with your upper arm and forearm creating a 90 degree angle. Be sure to maintain full control of the dumbbells at all times. This will be your starting position.",
                    "Then, as you breathe out, use your chest to push the dumbbells up. Lock your arms at the top of the lift and squeeze your chest, hold for a second and then begin coming down slowly. Tip: Ideally, lowering the weight should take about twice as long as raising it.",
                    "Repeat the movement for the prescribed amount of repetitions of your training program."
                  ],
                  "category": "strength",
                  "images": [
                    "Dumbbell_Bench_Press/0.jpg",
                    "Dumbbell_Bench_Press/1.jpg"
                  ],
                  "id": "Dumbbell_Bench_Press"
                },
          {
            "name": "Seated Cable Rows",
            "force": "pull",
            "level": "beginner",
            "mechanic": "compound",
            "equipment": "cable",
            "primaryMuscles": [
              "middle back"
            ],
            "secondaryMuscles": [
              "biceps",
              "lats",
              "shoulders"
            ],
            "instructions": [
              "For this exercise you will need access to a low pulley row machine with a V-bar. Note: The V-bar will enable you to have a neutral grip where the palms of your hands face each other. To get into the starting position, first sit down on the machine and place your feet on the front platform or crossbar provided making sure that your knees are slightly bent and not locked.",
              "Lean over as you keep the natural alignment of your back and grab the V-bar handles.",
              "With your arms extended pull back until your torso is at a 90-degree angle from your legs. Your back should be slightly arched and your chest should be sticking out. You should be feeling a nice stretch on your lats as you hold the bar in front of you. This is the starting position of the exercise.",
              "Keeping the torso stationary, pull the handles back towards your torso while keeping the arms close to it until you touch the abdominals. Breathe out as you perform that movement. At that point you should be squeezing your back muscles hard. Hold that contraction for a second and slowly go back to the original position while breathing in.",
              "Repeat for the recommended amount of repetitions."
            ],
            "category": "strength",
            "images": [
              "Seated_Cable_Rows/0.jpg",
              "Seated_Cable_Rows/1.jpg"
            ],
            "id": "Seated_Cable_Rows"
          },
          {
            "name": "Wide-Grip Lat Pulldown",
            "force": "pull",
            "level": "beginner",
            "mechanic": "compound",
            "equipment": "cable",
            "primaryMuscles": [
              "lats"
            ],
            "secondaryMuscles": [
              "biceps",
              "middle back",
              "shoulders"
            ],
            "instructions": [
              "Sit down on a pull-down machine with a wide bar attached to the top pulley. Make sure that you adjust the knee pad of the machine to fit your height. These pads will prevent your body from being raised by the resistance attached to the bar.",
              "Grab the bar with the palms facing forward using the prescribed grip. Note on grips: For a wide grip, your hands need to be spaced out at a distance wider than shoulder width. For a medium grip, your hands need to be spaced out at a distance equal to your shoulder width and for a close grip at a distance smaller than your shoulder width.",
              "As you have both arms extended in front of you holding the bar at the chosen grip width, bring your torso back around 30 degrees or so while creating a curvature on your lower back and sticking your chest out. This is your starting position.",
              "As you breathe out, bring the bar down until it touches your upper chest by drawing the shoulders and the upper arms down and back. Tip: Concentrate on squeezing the back muscles once you reach the full contracted position. The upper torso should remain stationary and only the arms should move. The forearms should do no other work except for holding the bar; therefore do not try to pull down the bar using the forearms.",
              "After a second at the contracted position squeezing your shoulder blades together, slowly raise the bar back to the starting position when your arms are fully extended and the lats are fully stretched. Inhale during this portion of the movement.",
              "Repeat this motion for the prescribed amount of repetitions."
            ],
            "category": "strength",
            "images": [
              "Wide-Grip_Lat_Pulldown/0.jpg",
              "Wide-Grip_Lat_Pulldown/1.jpg"
            ],
            "id": "Wide-Grip_Lat_Pulldown"
          },
          {
            "name": "Dumbbell Shoulder Press",
            "force": "push",
            "level": "intermediate",
            "mechanic": "compound",
            "equipment": "dumbbell",
            "primaryMuscles": [
              "shoulders"
            ],
            "secondaryMuscles": [
              "triceps"
            ],
            "instructions": [
              "While holding a dumbbell in each hand, sit on a military press bench or utility bench that has back support. Place the dumbbells upright on top of your thighs.",
              "Now raise the dumbbells to shoulder height one at a time using your thighs to help propel them up into position.",
              "Make sure to rotate your wrists so that the palms of your hands are facing forward. This is your starting position.",
              "Now, exhale and push the dumbbells upward until they touch at the top.",
              "Then, after a brief pause at the top contracted position, slowly lower the weights back down to the starting position while inhaling.",
              "Repeat for the recommended amount of repetitions."
            ],
            "category": "strength",
            "images": [
              "Dumbbell_Shoulder_Press/0.jpg",
              "Dumbbell_Shoulder_Press/1.jpg"
            ],
            "id": "Dumbbell_Shoulder_Press"
          }
        ]
        """.data(using: .utf8)!
        
        do {
            let exercises = try JSONDecoder().decode([Exercise].self, from: jsonData)
            return exercises
        } catch {
            print("Error decoding sample data: \(error)")
            return []
        }
    }
}
