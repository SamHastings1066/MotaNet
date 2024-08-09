//
//  CreatePasswordView.swift
//  MotaNet
//
//  Created by sam hastings on 09/08/2024.
//

import SwiftUI

struct CreatePasswordView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(RegistrationViewModel.self) private var viewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        VStack(spacing:12) {
            Text("Create password")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("Your password must be at least six characters in length")
                .font(.footnote)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            SecureField("Password", text: $viewModel.password)
                .textInputAutocapitalization(.none)
                .modifier(IGTextFieldModifier())
                .padding(.top)
            
            NavigationLink {
                CompleteSignUpView()
                    .navigationBarBackButtonHidden()
            } label: {
                Text("Next")
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
    
    return NavigationStack {
        CreatePasswordView()
            .environment(registrationViewModel)
    }
}
