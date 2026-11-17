//
//  EditGoalScreen.swift
//  LearningJourney
//
//  Created by Nouf Fayez on 06/06/1448 AH.
//

import SwiftUI

struct EditGoalScreen: View {
    @Environment(LearningViewModel.self) private var learningVM
    @Environment(\.dismiss) private var dismiss

    @State private var viewModel: OnboardingViewModel
    @State private var showUpdateAlert = false

    init(goal: LearningGoal) {
        _viewModel = State(initialValue: OnboardingViewModel(goal: goal))
    }

    var body: some View {
        VStack(alignment: .leading) {
            GoalForm(viewModel: viewModel)
            Spacer()
        }
        .padding(.horizontal)
        .navigationTitle("Learning Goal")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    showUpdateAlert = true
                } label: {
                    Image(systemName: "checkmark")
                }
                .buttonStyle(.glassProminent)
                .tint(canSave ? Color("AppOrange") : .black.opacity(0.5))
                .disabled(!canSave)
            }
        }
        .alert("Update goal", isPresented: $showUpdateAlert) {
            Button("Dismiss", role: .cancel) { }
            Button("Update") {
                learningVM.SetGoal(viewModel.startLearning())
                dismiss()
            }
        } message: {
            Text("If you update now, your streak will start over.")
        }
        
    }
    
    // Save allowed if there's text AND (something changed OR the goal has ended)
    private var canSave: Bool {
        viewModel.canLearn && (viewModel.hasChanges || learningVM.goalProgress != .inProgress)
    }
}

#Preview {
    NavigationStack {
        EditGoalScreen(goal: LearningGoal(goalName: "Swift", Duration: .week, StartDtae: .now))
    }
    .environment(LearningViewModel())
    .preferredColorScheme(.dark)
}

