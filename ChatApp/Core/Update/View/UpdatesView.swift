//
//  UpdatesView.swift
//  ChatApp
//
//  Created by Jason Ngo on 14/06/2024.
//

import SwiftUI

struct UpdatesView: View {
    var activities = ["Archery", "Baseball", "Basketball", "Bowling", "Boxing", "Cricket", "Curling", "Fencing", "Golf", "Hiking", "Lacrosse", "Rugby", "Squash"]
    var colors: [Color] = [.blue, .cyan, .gray, .green, .indigo, .mint, .orange, .pink, .purple, .red]

    @State var selected = "Archery"
    @State private var id = 1

    var body: some View {
        VStack {
            Text("Why not try…")
                .font(.largeTitle.bold())
            
            VStack {
                Circle()
                    .fill(.blue)
                    .padding()
                    .overlay(
                        Image(systemName: "figure.\(selected.lowercased())")
                            .font(.system(size: 144))
                            .foregroundColor(.white)
                            .transition(.opacity)
                            .id(id)
                    )
                
                Text(selected)
                    .font(.title)
            }
            Button {
                withAnimation(.easeInOut(duration: 1)) {
                    selected = activities.randomElement() ?? "Archery"
                    id += 1
                }
            } label: {
                Text("Try again")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, alignment: .center)
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal, 20)
        }

    }
}

#Preview {
    UpdatesView()
}
