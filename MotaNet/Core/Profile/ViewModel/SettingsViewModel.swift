//
//  SettingsViewModel.swift
//  MotaNet
//
//  Created by sam hastings on 05/09/2024.
//

import Foundation

@Observable
class SettingsViewModel {
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func logoutUser() {
        AuthService.shared.signout()
    }
}
