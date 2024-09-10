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
            content()
        }
    }
    
    @ViewBuilder
    func content() -> some View {
        switch AuthService.shared.loggedIn {
        case false:
            LoginView()
                .environment(registrationViewModel)
        case true:
            if let currentUser = AuthService.shared.currentUser {
                MainTabView(user: currentUser)
            } else {
                Text("No current user")
            }
        default:
            // TODO: Create better loading screen. Possibly the Mota Icon?
            Text("LOADING...")
        }
    }
}

#Preview {
    ContentView()
}
