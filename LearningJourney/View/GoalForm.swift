//
//  GoalForm.swift
//  LearningJourney
//
//  Created by Nouf Fayez on 06/06/1448 AH.
//

import SwiftUI

struct GoalForm: View {
    @Bindable var viewModel: OnboardingViewModel

    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 30) {
                Text("I want to learn")
                    .padding(.top)
                TextField("enter your goal", text: $viewModel.GoalText)
                Divider()
            }
            .padding(.vertical, 20)

            Text("I want to learn it in a")

            HStack {
                ForEach(GoalDuration.allCases, id: \.self) { duration in
                    Button {
                        viewModel.selectedDuration = duration
                    } label: {
                        Text(duration.title)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .glassEffect(
                                .regular.tint(
                                    viewModel.selectedDuration == duration
                                        ? Color("AppOrange")
                                        : Color(.darkGray)
                                ),
                                in: .capsule
                            )
                    }
                }
            }
        }
    }
}

#Preview {
    GoalForm(viewModel: OnboardingViewModel())
        .padding()
        .preferredColorScheme(.dark)
}
