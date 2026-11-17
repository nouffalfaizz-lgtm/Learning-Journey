//
//  CalendarViewModel.swift
//  LearningJourney
//
//  Created by Nouf Fayez on 06/06/1448 AH.
//

import Foundation
import Observation

@Observable
class CalendarViewModel {
    private let calendar = Calendar.current

    var weekdaySymbols: [String] {
        calendar.shortWeekdaySymbols.map { $0.uppercased() }
    }

    func months(since startDate: Date) -> [Date] {
        guard let first = calendar.dateInterval(of: .month, for: startDate)?.start,
              let last = calendar.dateInterval(of: .month, for: .now)?.start else {
            return []
        }
        var result: [Date] = []
        var current = first
        while current <= last {
            result.append(current)
            guard let next = calendar.date(byAdding: .month, value: 1, to: current) else { break }
            current = next
        }
        return result
    }

    func days(in month: Date) -> [Date?] {
        guard let range = calendar.range(of: .day, in: .month, for: month) else { return [] }
        let firstWeekday = calendar.component(.weekday, from: month)
        let blanks: [Date?] = Array(repeating: nil, count: firstWeekday - 1)
        let dates: [Date?] = range.map { day in
            calendar.date(byAdding: .day, value: day - 1, to: month)
        }
        return blanks + dates
    }

    func title(for month: Date) -> String {
        month.formatted(.dateTime.month(.wide).year())
    }
}
