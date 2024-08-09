//
//  XSmallUserView.swift
//  MotaNet
//
//  Created by sam hastings on 09/08/2024.
//

import SwiftUI

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
