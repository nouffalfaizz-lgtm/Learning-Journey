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
    
    private let goalKey = "savedGoal"
    private let logsKey = "savedLogs"

    init() {
        load()
    }
    
    
    func SetGoal(_ newgoal: LearningGoal){
        goal = newgoal
        save() // saves the goal user chosses
    }
    
    
    var currentGoalLogs: [DayLog] {
        guard let start = goal?.StartDtae else { return [] }
        return logs.filter { log in log.date >= start }
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
    
    
    
    var firstActivityDate: Date {
        let dates = logs.map { log in log.date } + [goal?.StartDtae ?? .now]
        return dates.min() ?? .now
    }

       // What the user did on a date. nil = nothing logged that day
    func status(for date: Date) -> DayStatus? {
        logs.last { log in
            Calendar.current.isDate(log.date, inSameDayAs: date)
        }?.status
    }
    
    // Counts : How many days were logged as learned
    var learnedCount: Int {
        currentGoalLogs.filter{ log in log.status == .Learned }.count
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
        currentGoalLogs.last { log in
            Calendar.current.isDateInToday(log.date)
        }?.status
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
    
    // Goal progress
    private let streakLimit: TimeInterval = 32 * 60 * 60

    var lastActivityDate: Date? {
        currentGoalLogs.last?.date ?? goal?.StartDtae
    }

    var goalProgress: GoalProgress {
        guard let goal else { return .inProgress }
        
        // 🧪 DEBUG: test the Goal Ended screen.
        // Uncomment ONE line below, run, then comment it again before committing.
//         return .completed
//         return .notMet

        if currentGoalLogs.count >= goal.Duration.totalDays {
            return .completed
        }

        if let last = lastActivityDate,
           Date.now.timeIntervalSince(last) > streakLimit {
            return .notMet
        }

        return .inProgress
    }

    //Actions
    func logAsLearned() {
        guard goalProgress == .inProgress, !isTodayLogged else { return }
        logs.append(DayLog(date: .now, status: .Learned))
        save()
    }

    func freezeToday() {
        guard goalProgress == .inProgress, canFreeze else { return }
        logs.append(DayLog(date: .now, status: .Freezeed))
        save()
    }
    
    // Removes today's "learned" log for the current goal
    func undoLearnedToday() {
        guard let start = goal?.StartDtae else { return }
        logs.removeAll { log in
            log.status == .Learned
            && log.date >= start
            && Calendar.current.isDateInToday(log.date)
        }
        save()
    }

    // The big button: log if not logged yet, undo if already learned today
    func toggleLearnedToday() {
        if todayStatus == .Learned {
            undoLearnedToday()
        } else {
            logAsLearned()
        }
    }
    
    // Saving
    private func save() {
        let encoder = JSONEncoder()
        if let goal, let goalData = try? encoder.encode(goal) {
            UserDefaults.standard.set(goalData, forKey: goalKey)
        }
        if let logsData = try? encoder.encode(logs) {
            UserDefaults.standard.set(logsData, forKey: logsKey)
        }
    }
      // loading
    private func load() {
        let decoder = JSONDecoder()
        if let goalData = UserDefaults.standard.data(forKey: goalKey),
           let savedGoal = try? decoder.decode(LearningGoal.self, from: goalData) {
            goal = savedGoal
        }
        if let logsData = UserDefaults.standard.data(forKey: logsKey),
           let savedLogs = try? decoder.decode([DayLog].self, from: logsData) {
            logs = savedLogs
        }
    }
   }
    
    

