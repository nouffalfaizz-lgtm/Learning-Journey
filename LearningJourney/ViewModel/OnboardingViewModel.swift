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
    
    // The goal the form started with (nil in Onboarding)
    private let originalGoal: LearningGoal?
    
    init(goal: LearningGoal? = nil) {
        originalGoal = goal
        GoalText = goal?.goalName ?? ""
        selectedDuration = goal?.Duration ?? .week
    }
    
    var canLearn : Bool {
        !GoalText.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    // true if the user changed the topic or the duration
    var hasChanges: Bool {
        guard let originalGoal else { return true }   // Onboarding: nothing to compare
        let typedText = GoalText.trimmingCharacters(in: .whitespaces)
        return typedText != originalGoal.goalName || selectedDuration != originalGoal.Duration
    }
    
    func startLearning () -> LearningGoal{
        let goal = LearningGoal(goalName: GoalText, Duration: selectedDuration, StartDtae: .now)
       return goal
    }
}

