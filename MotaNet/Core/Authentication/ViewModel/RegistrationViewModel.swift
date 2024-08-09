//
//  RegistrationViewModel.swift
//  MotaNet
//
//  Created by sam hastings on 09/08/2024.
//

import Foundation

@Observable
class RegistrationViewModel {
    var username = ""
    var email = ""
    var password = ""
    
    func createUser() async throws {
        try await AuthService.shared.createUser(email: email, password: password, username: username)
        
        username = ""
        email = ""
        password = ""
    }
}
