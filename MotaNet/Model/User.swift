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
//        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
//        return currentUid == id
        return true
    }
}

extension User {
    static var MOCK_USERS: [User] = [
        .init(id: "kNGoA7iAzxbWxlztKNUF4ojsN6v2", username: "Black Panther", profileImageUrl: "https://firebasestorage.googleapis.com:443/v0/b/motanet-ca3e7.appspot.com/o/profile_images%2F9A43C364-8CCB-4A9C-913D-2CC1836C40F9?alt=media&token=ef074fb1-33b4-49ad-bb6c-62d758b8ea81", fullname: "Chadwick Bozeman", bio: "Black panther guy", email: "bp@gmail.com"),
        .init(id: "venom", username: "Venom", profileImageUrl: nil, fullname: "Eddie Brock", bio: "Venom", email: "venom@gmail.com"),
        .init(id: "iron_man", username: "Iron Man", profileImageUrl: nil, fullname: "One Bredda", bio: "ironman guy", email: "ironman@gmail.com"),
        .init(id: "batman", username: "Batman", profileImageUrl: nil, fullname: "Two Bredda", bio: "batman guy", email: "batman@gmail.com"),
        .init(id: "spiderman", username: "Spiderman", profileImageUrl: nil, fullname: "Tree Bredda", bio: "spiderman guy", email: "spiderman@gmail.com")
    ]
}
