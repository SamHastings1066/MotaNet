//
//  SearchViewModel.swift
//  MotaNet
//
//  Created by sam hastings on 04/09/2024.
//

import Foundation

@Observable
class SearchViewModel {
    var users: [User] = []
    var isLoading = true
    var errorMessage: String?
    
    func loadUsers() async {
        isLoading = true
        do {
            users = try await UserService.fetchAllUsers()
            errorMessage = nil
        } catch {
            errorMessage = "Could not load users: \(error.localizedDescription)"
        }
        isLoading = false
    }
}
