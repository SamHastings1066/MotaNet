//
//  LoginViewModel.swift
//  MotaNet
//
//  Created by sam hastings on 09/08/2024.
//

import Foundation

@Observable
class LoginViewModel {
    var email = ""
    var password = ""
    
    func signIn() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
}
