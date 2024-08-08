//
//  ContentView.swift
//  MotaNet
//
//  Created by sam hastings on 08/08/2024.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            MainTabView(user: User.MOCK_USERS[0])
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
