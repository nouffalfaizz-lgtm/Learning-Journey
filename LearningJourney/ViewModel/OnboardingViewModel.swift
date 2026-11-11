//
//  OnboardingViewModel.swift
//  LearningJourney
//
//  Created by Nouf Fayez on 30/05/1448 AH.
//

import Foundation
import Observation

@Observable
class OnboardingViewModel {
    
    var GoalText : String = ""
    var selectedDuration : GoalDuration = .week
    
    var canLearn : Bool {
        !GoalText.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    func startLearning (){
        let goal = LearningGoal(goalName: GoalText, Duration: selectedDuration, StartDtae: .now)
        print(goal)
    }
}

