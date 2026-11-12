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
    
    var goal : LearningGoal? = nil
    
    func SetGoal(_ newgoal: LearningGoal){
        goal = newgoal
    }
    
}
