//
//  ActivityScreen.swift
//  LearningJourney
//
//  Created by Nouf Fayez on 02/06/1448 AH.
//

import SwiftUI


struct ActivityScreen: View {
    let goal: LearningGoal
    var body: some View {
        HStack{
            VStack(alignment:.leading){
              Text("Activtiy")
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 41))
                
                
                
            }
            
            
            
        }
    }
}

#Preview {
    ActivityScreen(goal: LearningGoal(goalName: "Swift", Duration: .week , StartDtae: .now))
        .preferredColorScheme(.dark)
}
