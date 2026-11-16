//
//  GoalDuration .swift
//  LearningJourney
//
//  Created by Nouf Fayez on 30/05/1448 AH.
//

import Foundation

enum GoalDuration: String , CaseIterable , Codable{
    case week
    case month
    case year
    
    var title: String {
        switch self {
        case .week:
            return "Week"
        case .month:
            return "Month"
        case .year:
            return "Year"
        }
    }
    
    var FreezDays: Int {
        switch self {
        case .week:
            return 2
        case .month:
            return 8
        case .year:
            return 96
        }
    }
    
    var totalDays: Int {
        switch self {
        case .week:
            return 7
        case .month:
            return 30
        case .year:
            return 365
        }
    }
}
