//
//  ActivityScreen.swift
//  LearningJourney
//
//  Created by Nouf Fayez on 02/06/1448 AH.
//

import SwiftUI


struct ActivityScreen: View {
    let goal: LearningGoal
    @Environment(LearningViewModel.self) private var learningVM
    var body: some View {
        
        TimelineView(.everyMinute) { _ in
        
        VStack(alignment:.leading , spacing: 24){
            //the header
            HStack{
                VStack(alignment: .leading){
                    Text("Activtiy")
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 41))
                    
                    Text(Date.now, format: .dateTime.weekday(.wide).day().month(.wide))
                        .foregroundStyle(.appGrey)
                    
                }
                Spacer()
                
                HStack{
                    //calender page button
                    NavigationLink {
                        CalendarScreen()
                    } label: {
                        Image(systemName: "calendar")
                            .foregroundStyle(.white)
                            .frame(width: 45, height: 45)
                            .glassEffect(.regular.tint(.black.opacity(0.5)).interactive(), in: .circle)
                            .padding()
                    }
                    
                    //notes page button
                    NavigationLink {
                        EditGoalScreen(goal: goal)
                    } label: {
                        Image(systemName: "pencil.and.outline")
                            .foregroundStyle(.white)
                            .frame(width: 45, height: 45)
                            .glassEffect(.regular.tint(.black.opacity(0.5)).interactive(), in: .circle)
                    }
                }
                
            }
            
            // Week days calender
                      VStack(spacing: 5) {
                          HStack {
                              ForEach(0..<7, id: \.self) { index in
                                  Text(Calendar.current.veryShortWeekdaySymbols[index])
                                      .font(.caption.bold())
                                      .frame(maxWidth: .infinity)
                              }
                          }

                          // Real dates of this week + real status from the logs
                          HStack {
                              ForEach(learningVM.currentWeekDates, id: \.self) { date in
                                  DayCircle(date: date, status: learningVM.status(for: date))
                                      .frame(maxWidth: .infinity)
                              }
                          }
                          
                          // Stat cards
                          HStack(spacing: 12) {
                              StatCard(
                                  icon: "flame.fill",
                                  color: Color("AppOrange"),
                                  value: learningVM.dayText(for: learningVM.learnedCount),
                                  label: "Learned"
                              )
                              StatCard(
                                  icon: "snowflake",
                                  color: .appBlue,
                                  value: learningVM.dayText(for: learningVM.freezedCount),
                                  label: "Freezed"
                              )
                              .padding(.vertical)
                          }
                          
                      }
            if learningVM.goalProgress == .inProgress {
                
            Spacer()

            // Log as Learned circle button
            Button {
                learningVM.toggleLearnedToday()
            } label: {
                Text(bigButtonTitle)
                    .font(.title2)
                    .foregroundStyle(learningVM.todayStatus != nil ? Color("AppGrey") : .white)
                    .frame(width: 272, height: 272)
                    .glassEffect(.regular.tint(bigButtonColor).interactive(), in: .circle)
            }
            .disabled(learningVM.todayStatus == .Freezeed)
            .frame(maxWidth: .infinity)

            Spacer()

            // Freeze button
            VStack(spacing: 8) {
                Button {
                    learningVM.freezeToday()
                } label: {
                    Text("Freeze for a day")
                        .frame(width: 272)
                        .padding(.vertical, 8)
                }
                .buttonStyle(.glassProminent)
                .tint(Color("AppBlue"))
                .disabled(!learningVM.canFreeze)

                Text("\(learningVM.freezedCount) out of \(learningVM.freezeLimit) Freezes used")
                    .font(.caption)
                    .foregroundStyle(.appGrey)
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom)
            } else {
                Spacer()
                GoalEndedView(progress: learningVM.goalProgress, goal: goal)
                Spacer()
                Spacer()
            }
        }
        
        .padding(.horizontal)
        }
        .toolbar(.hidden, for: .navigationBar)
            
    }
    //Big button appearance

    private var bigButtonTitle: String {
        switch learningVM.todayStatus {
        case nil:      return "Log as Learned"
        case .Learned: return "Logged as Learned"
        case .Freezeed: return "Day Freezed"
        }
    }

    private var bigButtonColor: Color {
        switch learningVM.todayStatus {
        case nil:      return Color("AppOrange")
        case .Learned, .Freezeed: return Color(white: 0.12)
        }
    }
    
    
}

#Preview {
    NavigationStack {
        ActivityScreen(goal: LearningGoal(goalName: "Swift", Duration: .week, StartDtae: .now))
    }
    .environment(LearningViewModel())
    .preferredColorScheme(.dark)
}
