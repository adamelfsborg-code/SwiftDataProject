//
//  EditUserView.swift
//  SwiftDataProject
//
//  Created by Adam Elfsborg on 2024-08-03.
//
import SwiftData
import SwiftUI

struct EditUserView: View {
    @Bindable var user: User
    var body: some View {
        Form {
            TextField("Name", text: $user.name)
            TextField("City", text: $user.city)
            DatePicker("Join Date", selection: $user.joinDate)
        }
        .navigationTitle("Edit user")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let contianer = try ModelContainer(for: User.self, configurations: config)
        
        let user = User(name: "Warren Buffert", city: "New York", joinDate: .now)
        return EditUserView(user: user)
            .modelContainer(contianer)
    } catch {
        return Text("Failed to preview EditUserView: \(error.localizedDescription)")
    }
}
