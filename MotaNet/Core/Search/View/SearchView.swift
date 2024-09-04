//
//  SearchView.swift
//  MotaNet
//
//  Created by sam hastings on 09/08/2024.
//

import SwiftUI

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    if viewModel.isLoading {
                        ProgressView()
                            .task {
                                await viewModel.loadUsers()
                            }
                    } else {
                        ForEach(viewModel.users) { user in
                        //ForEach(User.MOCK_USERS) { user in
                            NavigationLink(value: user) {
                                HStack {
                                    CircularProfileImageView(user: user, size: .xSmall)
                                    
                                    VStack(alignment: .leading) {
                                        Text(user.username)
                                            .fontWeight(.semibold)
                                        if let fullname = user.fullname {
                                            Text(fullname)
                                        }
                                    }
                                    .font(.footnote)
                                    
                                    Spacer()
                                }
                                .foregroundStyle(.black)
                                .padding(.horizontal)
                            }
                        }
                    }
                }
                .padding(.top, 8)
                .searchable(text: $searchText, prompt: "Search...")
            }
            .navigationDestination(for: User.self, destination: { user in
                ProfileView(user: user)
            })
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SearchView()
}
