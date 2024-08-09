//
//  ProfileView.swift
//  MotaNet
//
//  Created by sam hastings on 08/08/2024.
//

import SwiftUI

struct ProfileView: View {
    
    let user: User
    
//    var posts: [Post] {
//        return Post.MOCK_POSTS.filter{ $0.user?.username == user.username}
//    }
    
    var body: some View {
            ScrollView {
                // Header
                ProfileHeaderView(user: user)
                // post grid view
                //PostGridView(user: user) - WorkoutGridView
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ProfileView(user: User.MOCK_USERS[0])
}
