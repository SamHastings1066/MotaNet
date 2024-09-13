//
//  CalendarViewModel.swift
//  MotaNet
//
//  Created by sam hastings on 04/09/2024.
//

import Foundation
import Firebase

@Observable
class CalendarViewModel {
    let user: User
    let calendar = Calendar.current
    let startDate: Date
    let endDate: Date
    var completedWorkouts: [WorkoutCompleted] = []
    var isLoading =  true
    var errorMessage: String?
    
    private var listener: ListenerRegistration?
    
    init(user: User) {
        self.user = user
        let currentYear = calendar.component(.year, from: Date())
        let currentMonth = calendar.component(.month, from: Date())
        self.startDate = calendar.date(from: DateComponents(year: currentYear, month: currentMonth, day: 1))!
        self.endDate = calendar.date(from: DateComponents(year: currentYear, month: currentMonth + 1, day: 30))!
        addWorkoutsListener()
    }
    
    deinit {
        listener?.remove()
    }
    
    func addWorkoutsListener() {
        isLoading = true
        listener = WorkoutService.db.collection("WorkoutsCompleted").addSnapshotListener { [weak self] snapshot, error in
            guard let self else { return }
            if let error {
                self.errorMessage = "Could not load completed workouts: \(error.localizedDescription)"
                self.isLoading = false
                return
            }
            
            guard let documents = snapshot?.documents else {
                self.errorMessage = "No workouts found."
                self.isLoading = false
                return
            }
            
            self.completedWorkouts = documents.compactMap{ try? $0.data(as: WorkoutCompleted.self) }
            self.errorMessage = nil
            self.isLoading = false
        }
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
