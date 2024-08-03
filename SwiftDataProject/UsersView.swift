//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by Adam Elfsborg on 2024-08-03.
//

import SwiftData
import SwiftUI

struct UsersView: View {
    @Query var users: [User]
    var body: some View {
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
    }
    
    init(mininumJoinedDate: Date, sortOrder: [SortDescriptor<User>]) {
        _users = Query(filter: #Predicate<User> { user in
            user.joinDate >= mininumJoinedDate
        }, sort: sortOrder)
    }
}

#Preview {
    UsersView(mininumJoinedDate: .now, sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
