//
//  LearningViewModel.swift
//  LearningJourney
//
//  Created by Nouf Fayez on 02/06/1448 AH.
//

import Foundation
import Observation

@Observable
class LearningViewModel{
    
    var goal : LearningGoal? = nil // current goal = empty
    var logs : [DayLog] = [] // saves the user learned or freezed
    
    func SetGoal(_ newgoal: LearningGoal){
        goal = newgoal
    }
    
     // The 7 dates of the current week from Sunday to Saturday
       var currentWeekDates: [Date] {
           let calendar = Calendar.current
           guard let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: .now)?.start else {
               return []
           }
           return (0..<7).compactMap { offset in
               calendar.date(byAdding: .day, value: offset, to: startOfWeek)
           }
       }

       // What the user did on a date. nil = nothing logged that day
    func status(for date: Date) -> DayStatus? {
        logs.first { log in
            Calendar.current.isDate(log.date, inSameDayAs: date)
        }?.status
    }
    
    // Counts : How many days were logged as learned
    var learnedCount: Int {
        logs.filter { log in log.status == .Learned }.count
    }
    
    // How many days were freezed
    var freezedCount: Int {
        logs.filter { log in log.status == .Freezeed }.count
    }
    
    // 1 (day) or 3 day
    func dayText(for count: Int) -> String {
        count == 1 ? "\(count) Day" : "\(count) Days"
    }
    
    //Today

    // What the user did today. nil = nothing logged yet.
    var todayStatus: DayStatus? {
        status(for: .now)
    }

    // Rule: buttons are disabled once a day is logged
    var isTodayLogged: Bool {
        todayStatus != nil
    }

    // Freezes

    // The limit depends on the goal
    var freezeLimit: Int {
        goal?.Duration.FreezDays ?? 0
    }

    // Rule: Freeze is disabled if today is logged OR all freezes are used
    var canFreeze: Bool {
        !isTodayLogged && freezedCount < freezeLimit
    }

    //Actions

    func logAsLearned() {
        guard !isTodayLogged else { return }
        logs.append(DayLog(date: .now, status: .Learned))
    }

    func freezeToday() {
        guard canFreeze else { return }
        logs.append(DayLog(date: .now, status: .Freezeed))
    }
   }
    
    

