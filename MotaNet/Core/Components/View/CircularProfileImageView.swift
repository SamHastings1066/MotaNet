//
//  CircularProfileImageView.swift
//  MotaNet
//
//  Created by sam hastings on 08/08/2024.
//

import SwiftUI
import Kingfisher

enum ProfileImageSize {
    case xSmall
    case small
    case medium
    case large
    
    var dimension: CGFloat {
        switch self {
        case .xSmall:
            40
        case .small:
            48
        case .medium:
            64
        case .large:
            80
        }
    }
}

// TODO: Update CircularProfileImageView to use userId not user since workouts will no longer have users, or else maybe they should have a small amount of info under the user property. Hmm...
struct CircularProfileImageView: View {
    let user: User
    let size: ProfileImageSize
    
    var body: some View {
        if let imageUrl = user.profileImageUrl {
            KFImage(URL(string: imageUrl))
            //Image(imageUrl)
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
                .foregroundStyle(Color(.systemGray4))
        }
        
    }
}

#Preview {
    CircularProfileImageView(user: User.MOCK_USERS[0], size: .large)
}
