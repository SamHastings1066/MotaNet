//
//  CalendarView.swift
//  MotaNet
//
//  Created by sam hastings on 09/08/2024.
//

import SwiftUI
import HorizonCalendar

struct CalendarView: View {
    @State private var selectedDate: Date?
    @State private var presentedWorkouts: [[WorkoutCompleted]] = []
    @State var viewModel: CalendarViewModel
    
    
    
    init(user: User) {
        _viewModel = State(initialValue: CalendarViewModel(user: user))
    }
    
    var body: some View {
        NavigationStack(path: $presentedWorkouts) {
            if viewModel.isLoading {
                ProgressView()
                    .task {
                        await viewModel.loadCompletedWorkoutsForUser()
                    }
            } else {
                    CalendarViewRepresentable(
                        calendar: viewModel.calendar,
                        visibleDateRange: viewModel.startDate...viewModel.endDate,
                        monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()),
                        dataDependency: nil
                    )
                    .onDaySelection { day in
                        selectedDate = viewModel.calendar.date(from: day.components)
                        if let date = viewModel.calendar.date(from: day.components) {
                            let workoutsForSelectedDay = viewModel.completedWorkouts.filter { workout in
                                viewModel.calendar.isDate(workout.startTime, equalTo: date, toGranularity: .day)
                            }
                            presentedWorkouts = [workoutsForSelectedDay]
                        }
                    }
                    .days { day in
                        let dateComponents = day.components
                        if let date = viewModel.calendar.date(from: dateComponents) {
                            let filteredWorkouts = viewModel.completedWorkouts.filter { workout in
                                viewModel.calendar.isDate(workout.startTime, equalTo: date, toGranularity: .day)
                            }
                            let totalVolume: Int = filteredWorkouts.reduce(0) { $0 + WorkoutStats.compute(from: $1).totalVolume }
                            
                            VStack {
                                ZStack {
                                    Circle()
                                        .stroke(
                                            filteredWorkouts.count > 0 ? Color(UIColor.systemGreen) : Color(UIColor.clear),
                                            lineWidth: 3
                                        )
                                        .frame(width: 40, height: 40)
                                    Text("\(day.day)")
                                        .font(.system(size: 20))
                                        .foregroundColor(Color(UIColor.label))
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                }
                                Text(totalVolume == 0 ? "~" : "\(totalVolume)")
                                    .font(.system(size: 12))
                            }
                        } else {
                            Text("Error")
                        }
                    }
                    .interMonthSpacing(24)
                    .verticalDayMargin(38)
                    .horizontalDayMargin(8)
                    .layoutMargins(.init(top: 8, leading: 8, bottom: 8, trailing: 8))
                    .padding(.horizontal, 16)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .navigationDestination(for: [WorkoutCompleted].self) { workoutsForSelectedDay in
                        CompletedWorkoutsForDayView(workouts: workoutsForSelectedDay)//, date: selectedDate)
                    }
                }
        }
    }
}

#Preview {
    CalendarView(user: User.MOCK_USERS[0])
}
