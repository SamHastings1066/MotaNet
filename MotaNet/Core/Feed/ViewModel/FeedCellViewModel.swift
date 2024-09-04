//
//  FeedCellViewModel.swift
//  MotaNet
//
//  Created by sam hastings on 04/09/2024.
//

import Foundation

@Observable
class FeedCellViewModel {
    var user: User?
    var isLoading = true 
    var errorMessage: String?
    
    func loadUser(id: String) async {
        
        isLoading = true
        do {
            user = try await UserService.fetchUser(withUid: id)
            errorMessage = nil
        } catch {
            errorMessage = "Could not load user: \(error.localizedDescription)"
        }
        isLoading = false
    }
}
