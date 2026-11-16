//
//  StatCard.swift
//  LearningJourney
//
//  Created by Nouf Fayez on 05/06/1448 AH.
//

import SwiftUI

struct StatCard: View {
    let icon: String      
    let color: Color
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(color)

            Text(value)
                .font(.headline)
                .foregroundStyle(.white)

            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .glassEffect(.regular, in: .rect(cornerRadius: 20))
    }
}

#Preview {
    StatCard(icon: "flame.fill", color: .orange, value: "1 Day", label: "Learned")
        .padding()
        .preferredColorScheme(.dark)
}
