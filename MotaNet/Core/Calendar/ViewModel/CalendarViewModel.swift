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
    var completedWorkouts: [WorkoutCompleted] = []
    var isLoading =  true
    var errorMessage: String?
    
    init(user: User) {
        self.user = user
        let currentYear = calendar.component(.year, from: Date())
        let currentMonth = calendar.component(.month, from: Date())
        self.startDate = calendar.date(from: DateComponents(year: currentYear, month: currentMonth, day: 1))!
        self.endDate = calendar.date(from: DateComponents(year: currentYear, month: currentMonth + 1, day: 30))!
    }
    
    func loadCompletedWorkoutsForUser() async {
        isLoading = true
        do {
            completedWorkouts = try await WorkoutService.fetchAllCompletedWorkoutsForUser(uid: user.id)
            errorMessage = nil
        } catch {
            errorMessage = "Could not load completed workouts: \(error.localizedDescription)"
        }
        isLoading = false
    }
}
