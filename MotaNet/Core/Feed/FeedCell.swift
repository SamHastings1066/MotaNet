//
//  FeedCell.swift
//  MotaNet
//
//  Created by sam hastings on 09/08/2024.
//

import SwiftUI

struct FeedCell: View {
    let workout: WorkoutCompleted
    
    var body: some View {
        VStack {
            // Image + username
            if let user = workout.user {
                XSmallUserView(user: user)
            }
            // WorkoutSummary
            CompletedWorkoutSummaryView(workout: workout)
            
            // Action buttons
            HStack(spacing: 16) {
                Button {
                    print("Like post")
                } label: {
                    Image(systemName: "heart")
                        .imageScale(.large)
                }
                
                Button {
                    print("Comment on post")
                } label: {
                    Image(systemName: "bubble.right")
                        .imageScale(.large)
                }
                
                Button {
                    print("Share post")
                } label: {
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                }
                Spacer()
            }
            .padding(.leading, 8)
            .padding(.top, 4)
            .foregroundStyle(.black)
            
            // Likes lable
            Text("\(workout.likes) likes")
                .font(.footnote)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
                .padding(.top, 1)
            
            // caption label
            HStack {
                Text("\(workout.user?.username ?? "") ").fontWeight(.semibold) +
                Text(workout.caption)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.footnote)
            .padding(.leading, 10)
            .padding(.top, 1)
            
            // Timestamp lable
            Text("6h ago")
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
                .padding(.top, 1)
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    FeedCell(workout: WorkoutCompleted.MOCK_WORKOUTS[0])
}
