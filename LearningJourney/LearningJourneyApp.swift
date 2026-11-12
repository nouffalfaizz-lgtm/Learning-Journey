//
//  LearningJourneyApp.swift
//  LearningJourney
//
//  Created by Nouf Fayez on 29/05/1448 AH.
//

import SwiftUI

@main
struct LearningJourneyApp: App {
    @State private var LViewModel = LearningViewModel()
    
    var body: some Scene {
        WindowGroup {
            
            // if there's a goal --> go to Activtiy page
            Group{
                if let goal = LViewModel.goal{
                    Text(goal.goalName)
                }else{
                    // if there's no goal(or first time user) go to On Borading page
                    OnBoarding()
                }
            }
            .environment(LViewModel)
            .preferredColorScheme(.dark)
        }
    }
}
