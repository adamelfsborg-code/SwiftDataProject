//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Adam Elfsborg on 2024-08-03.
//
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var searchTerm = ""
    @State private var showingUpcommingOnly = false
    @State private var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate)
    ]
    
    var body: some View {
        NavigationStack {
            UsersView(mininumJoinedDate: showingUpcommingOnly ? .now : .distantPast, sortOrder: sortOrder)
            .navigationTitle("Vikings")
            .toolbar {
                Button(showingUpcommingOnly ? "Show everyone" : "Show upcomming") { showingUpcommingOnly.toggle() }
                Button("Add vikings to boat", systemImage: "plus") {
                    try? modelContext.delete(model: User.self)
                   
                    let names = ["Floki", "Björn", "Ragnar", "Rollo"]
                    let cities = ["Kattegat", "Wessex", "Paris", "Asgard"]
                    for _ in 1...4 {
                        let user = User(name: names.randomElement()!, city: cities.randomElement()!, joinDate: .now.addingTimeInterval(TimeInterval(86400 * Int.random(in: -10...10)) ))
                        modelContext.insert(user)
                    }
                }
                
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\User.name),
                                SortDescriptor(\User.joinDate)
                            ])
                        Text("Sort by Join Date")
                            .tag([
                                SortDescriptor(\User.joinDate),
                                SortDescriptor(\User.name)
                            ])
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: User.self)
}
