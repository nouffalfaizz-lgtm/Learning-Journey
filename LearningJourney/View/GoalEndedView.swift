//
//  GoalEndedView.swift
//  LearningJourney
//
//  Created by Nouf Fayez on 06/06/1448 AH.
//

import SwiftUI

struct GoalEndedView: View {
    let progress: GoalProgress
    let goal: LearningGoal

    private var icon: String {
        switch progress {
        case .completed:  return "hands.clap.fill"
        case .notMet:     return "xmark.seal"
        case .inProgress: return ""
        }
    }

    private var title: String {
        switch progress {
        case .completed:  return "Well done!"
        case .notMet:     return "You didn't reach your goal this time."
        case .inProgress: return ""
        }
    }

    private var subtitle: String {
        switch progress {
        case .completed:  return "Ready for your next goal?"
        case .notMet:     return "Want to set another goal?"
        case .inProgress: return ""
        }
    }

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 40))
                .foregroundStyle(Color("AppOrange"))
                .padding(.bottom, 8)

            Text(title)
                .font(.headline)

            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(Color("AppGrey"))

            NavigationLink {
                EditGoalScreen(goal: goal)
            } label: {
                Label("Set a goal", systemImage: "pencil.and.outline")
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
            }
            .buttonStyle(.glassProminent)
            .tint(Color("AppOrange"))
            .padding(.top, 24)
        }
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    NavigationStack {
        GoalEndedView(
            progress: .completed,
            goal: LearningGoal(goalName: "Swift", Duration: .week, StartDtae: .now)
        )
    }
    .environment(LearningViewModel())
    .preferredColorScheme(.dark)
}
