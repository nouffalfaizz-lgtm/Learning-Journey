//
//  DayCircle.swift
//  LearningJourney
//
//  Created by Nouf Fayez on 05/06/1448 AH.
//

import SwiftUI

struct DayCircle: View {
    let date: Date
    let status: DayStatus?

    // Worked out from the date, so nobody has to pass it in
    private var isToday: Bool {
        Calendar.current.isDateInToday(date)
    }

    private var dayNumber: Int {
        Calendar.current.component(.day, from: date)
    }

    private var circleColor: Color {
        
        // Today with nothing logged is checked first: solid orange
        if isToday && status == nil {
            return Color("AppOrange")
        }
        switch status {
        case .Learned: return Color("AppOrange").opacity(0.25)
        case .Freezeed: return Color.blue.opacity(0.25)
        case nil:      return .clear
        }
    }

    private var textColor: Color {
        if isToday && status == nil {
            return .white
        }
        switch status {
        case .Learned: return Color("AppOrange")
        case .Freezeed: return .blue
        case nil:      return .white
        }
    }

    var body: some View {
        Text("\(dayNumber)")
            .font(.system(size: 20, weight: .medium))
            .foregroundStyle(textColor)
            .frame(width: 44, height: 44)
            .background(Circle().fill(circleColor))
    }
}

#Preview {
    DayCircle(date: .now, status: nil)
        .preferredColorScheme(.dark)
}
