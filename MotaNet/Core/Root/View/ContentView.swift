//
//  ContentView.swift
//  MotaNet
//
//  Created by sam hastings on 08/08/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var registrationViewModel = RegistrationViewModel()
    
    var body: some View {
        Group {
            if AuthService.shared.userSession == nil {
                LoginView()
                    .environment(registrationViewModel)
            } else if let currentUser = AuthService.shared.currentUser {
                MainTabView(user: currentUser)
            }
        }
    }
}

#Preview {
    ContentView()
}
