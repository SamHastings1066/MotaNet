//
//  XSmallUserView.swift
//  MotaNet
//
//  Created by sam hastings on 09/08/2024.
//

import SwiftUI

// TODO: Update XSmallUserView to use userId not user since workouts will no longer have users, or else maybe they should have a small amount of info under the user property. Hmm...
struct XSmallUserView: View {
    let user: User
    var body: some View {
        HStack {
                CircularProfileImageView(user: user, size: .xSmall)
                Text(user.username)
                    .font(.footnote)
                    .fontWeight(.semibold)
            Spacer()
        }
        .padding(.leading, 8)
    }
}

#Preview {
    XSmallUserView(user: User.MOCK_USERS[0])
}
