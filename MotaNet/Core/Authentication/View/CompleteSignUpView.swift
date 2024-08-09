//
//  CompleteSignUpView.swift
//  MotaNet
//
//  Created by sam hastings on 09/08/2024.
//

import SwiftUI

struct CompleteSignUpView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(RegistrationViewModel.self) private var viewModel
    
    var body: some View {
        VStack(spacing:12) {
            Spacer()
            Text("Welcome to Instagram, \(viewModel.username)")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
                .multilineTextAlignment(.center)
            
            Text("Click below to complete registration and start using Instagram.")
                .font(.footnote)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            Button {
                Task {
                    try await viewModel.createUser()
                }
            } label: {
                Text("Complete Sign Up")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 360, height: 44)
                    .background(Color(.systemBlue))
                    .cornerRadius(8)
            }
            .padding(.vertical)
            
            Spacer()
            
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss()
                    }
            }
        }
    }
}

#Preview {
    @State var registrationViewModel = RegistrationViewModel()
    
    return CompleteSignUpView().environment(registrationViewModel)
}
