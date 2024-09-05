//
//  SettingsView.swift
//  MotaNet
//
//  Created by sam hastings on 05/09/2024.
//

import SwiftUI

struct SettingsView: View {
    @State var viewModel: SettingsViewModel
    @State private var isShowingLogoutAlert = false
    
    init(user: User) {
        _viewModel = State(initialValue: SettingsViewModel(user: user))
    }
    
    var body: some View {
        List {
            Button("Log out") {
                isShowingLogoutAlert = true
            }
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundStyle(.red)
        }
        .alert("Log out of account?", isPresented: $isShowingLogoutAlert) {
            Button("OK"){
                viewModel.logoutUser()
            }
            Button("Cancel", role: .cancel) {
                
            }
        }
    }
}

#Preview {
    SettingsView(user: User.MOCK_USERS[0])
}
