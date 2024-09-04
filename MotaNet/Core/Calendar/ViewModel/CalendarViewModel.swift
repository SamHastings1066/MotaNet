//
//  CalendarViewModel.swift
//  MotaNet
//
//  Created by sam hastings on 04/09/2024.
//

import Foundation

@Observable
class CalendarViewModel {
    let user: User
    let calendar = Calendar.current
    let startDate: Date
    let endDate: Date
    var workouts: [WorkoutCompleted] = []
    var isLoadingWorkouts =  true
    
    init(user: User) {
        self.user = user
        self.startDate = calendar.date(from: DateComponents(year: 2024, month: 08, day: 01))!
        self.endDate = calendar.date(from: DateComponents(year: 2024, month: 10, day: 30))!
    }
    
    func loadWorkouts() async {
        isLoadingWorkouts = true
        do {
            workouts = try await WorkoutService.fetchAllCompletedWorkoutsForUser(uid: user.id)
        } catch {
            print("Error loading workouts: \(error.localizedDescription)")
        }
        isLoadingWorkouts = false
    }
}
