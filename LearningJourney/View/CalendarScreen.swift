//
//  CalendarScreen.swift
//  LearningJourney
//
//  Created by Nouf Fayez on 06/06/1448 AH.
//

import SwiftUI

struct CalendarScreen: View {
    @Environment(LearningViewModel.self) private var learningVM
    @State private var viewModel = CalendarViewModel()

    private let columns = Array(repeating: GridItem(.flexible()), count: 7)

    var body: some View {
        ScrollViewReader { proxy in
        ScrollView {
            
            VStack(alignment: .leading, spacing: 24) {
                ForEach(viewModel.monthsOfThisYear, id: \.self) { month in
                    VStack(alignment: .leading, spacing: 12) {
                        Text(viewModel.title(for: month))
                            .font(.headline)

                        LazyVGrid(columns: columns, spacing: 8) {
                            ForEach(viewModel.weekdaySymbols, id: \.self) { symbol in
                                Text(symbol)
                                    .font(.caption2.bold())
                                    .foregroundStyle(Color("AppGrey"))
                            }
                            ForEach(Array(viewModel.days(in: month).enumerated()), id: \.offset) { _, date in
                                if let date {
                                    DayCircle(date: date, status: learningVM.status(for: date))
                                } else {
                                    Color.clear.frame(height: 44)
                                }
                            }
                        }

                        Divider()
                    }
                    .id(month)
                   
                }
                
            }
            .padding(.horizontal)
        }
        .onAppear {
            if let currentMonth = viewModel.currentMonth {
                proxy.scrollTo(currentMonth, anchor: .top)
            }
        }
        }
        Spacer()
        .defaultScrollAnchor(.bottom)
        .navigationTitle("Activities")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        CalendarScreen()
    }
    .environment(LearningViewModel())
    .preferredColorScheme(.dark)
}



