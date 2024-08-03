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
    @Query(
        filter: #Predicate<User> { user in
            user.name.localizedStandardContains("R") &&
            user.city == "Kattegat"
        },
        sort: \User.name
    ) var users: [User]
    
    var body: some View {
        NavigationStack {
            List(users) { user in
                HStack {
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.headline)
                        Text(user.city)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    Text(user.joinDate, format: .dateTime)
                    
                }
                    
            }
            .navigationTitle("Vikings")
            .toolbar {
                Button("Add vikings to boat", systemImage: "plus") {
                    try? modelContext.delete(model: User.self)
                   
                    let names = ["Floki", "Björn", "Ragnar", "Rollo"]
                    let cities = ["Kattegat", "Wessex", "Paris", "Asgard"]
                    for _ in 1...4 {
                        let user = User(name: names.randomElement()!, city: cities.randomElement()!, joinDate: .now.addingTimeInterval(TimeInterval(86400 * Int.random(in: -10...10)) ))
                        modelContext.insert(user)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
