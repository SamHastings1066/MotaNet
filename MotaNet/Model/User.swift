//
//  User.swift
//  MotaNet
//
//  Created by sam hastings on 08/08/2024.
//

import Foundation
import FirebaseAuth

struct User: Identifiable, Hashable, Codable {
    let id: String
    var username: String
    var profileImageUrl: String?
    var fullname: String?
    var bio: String?
    let email: String
    
    var isCurrentUser: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        return currentUid == id
    }
}

extension User {
    static var MOCK_USERS: [User] = [
        .init(id: NSUUID().uuidString, username: "Black Panther", profileImageUrl: nil, fullname: "Chadwick Bozeman", bio: "Black panther guy", email: "bp@gmail.com"),
        .init(id: NSUUID().uuidString, username: "Venom", profileImageUrl: nil, fullname: "Eddie Brock", bio: "Venom", email: "venom@gmail.com"),
        .init(id: NSUUID().uuidString, username: "Iron Man", profileImageUrl: nil, fullname: "One Bredda", bio: "ironman guy", email: "ironman@gmail.com"),
        .init(id: NSUUID().uuidString, username: "Batman", profileImageUrl: nil, fullname: "Two Bredda", bio: "batman guy", email: "batman@gmail.com"),
        .init(id: NSUUID().uuidString, username: "Spiderman", profileImageUrl: nil, fullname: "Tree Bredda", bio: "spiderman guy", email: "spiderman@gmail.com")
    ]
}
