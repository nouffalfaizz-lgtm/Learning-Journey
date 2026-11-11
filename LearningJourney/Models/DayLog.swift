//
//  DayLog.swift
//  LearningJourney
//
//  Created by Nouf Fayez on 30/05/1448 AH.
//

import Foundation

struct DayLog: Identifiable, Codable{
    
    var id = UUID()
    let date : Date
    let status : DayStatus
}
