//
//  OnBoarding.swift
//  LearningJourney
//
//  Created by Nouf Fayez on 30/05/1448 AH.
//

import SwiftUI

struct OnBoarding: View {
    
    //connecting the view with View model
@State private var viewModel = OnboardingViewModel()
    @Environment(LearningViewModel.self)private var learningViewModel
    var body: some View {
        VStack(alignment:.leading){
            //flame
            Image(systemName: "flame.fill")
                .foregroundStyle(Color("AppOrange"))
                .font(.system(size: 45))
                .frame(maxWidth: .infinity)
                .padding(.vertical,60)
            
            //texts
            Text("Hello Learner")
                .font(.system(size: 34))
                .fontWeight(.bold)
            Text("This app will help you learn everyday!")
                .foregroundStyle(Color("AppGrey"))
            
            
            //text feild
            VStack(alignment:.leading, spacing: 30){
            Text("I Want to learn")
                    .padding(.top)
            TextField("enter your goal", text: $viewModel.GoalText)
            Divider()
        }
            .padding(.vertical,20)
            
            Text("I want to learn it in a ")
            HStack{
                ForEach(GoalDuration.allCases, id:\.self){Duration in
                    Button{
                        viewModel.selectedDuration = Duration
                    }label: {
                        Text(Duration.title)
                            .foregroundStyle(.white)
                            .padding(.horizontal,16)
                            .padding(.vertical,8)
                            .glassEffect(
                                .regular.tint(
                                    viewModel.selectedDuration == Duration ? Color("AppOrange")
                                    : Color(.darkGray)
                                ), in: .capsule
                            )
                    }
                }
            }
          Spacer()
            
            Button {
                let newGoal = viewModel.startLearning()
                learningViewModel.SetGoal(newGoal)
                
            }label: {
                Text("Strat Learning")
                    .padding(.horizontal,20)
                    .padding(.vertical,8)
    
            }
            .buttonStyle(.glassProminent)
            .tint(.appOrange)
            .disabled(!viewModel.canLearn)
            .frame(maxWidth: .infinity)
            
        }
        .padding(.horizontal)
        
       
    }
}

#Preview {
    OnBoarding()
        .environment(LearningViewModel())
        .preferredColorScheme(.dark)
}


