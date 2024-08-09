//
//  LoginView.swift
//  MotaNet
//
//  Created by sam hastings on 09/08/2024.
//

import SwiftUI

struct LoginView: View {
    @State var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()
                
                // logo image
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 100)
                
                // text fields
                VStack {
                    TextField("Enter your email", text: $viewModel.email)
                        .textInputAutocapitalization(.none)
                        .modifier(IGTextFieldModifier())
                    SecureField("Enter your password", text: $viewModel.password)
                        .modifier(IGTextFieldModifier())
                    
                }
                
                Button {
                    print("Show forgot password")
                } label: {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .padding(.trailing, 20)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                Button {
                    Task {
                        try await viewModel.signIn()
                    }
                } label: {
                    Text("Login")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 360, height: 44)
                        .background(Color(.systemBlue))
                        .cornerRadius(8)
                }
                .padding(.vertical)
                
                HStack {
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5 )
                        
                    Text("OR")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5 )
                }
                .foregroundStyle(.gray)
                
                HStack {
                    Image("facebook-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                    
                    Text("Continue to Facebook")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(.systemBlue))
                }
                .padding(.top, 8)
                
                Spacer()
                
                Divider()
                NavigationLink {
                    AddEmailView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.semibold)
                    }
                    .font(.footnote)
                }
                .padding(.vertical, 16)

            }
        }
    }
}

#Preview {
    @State var registrationViewModel = RegistrationViewModel()
    
    return LoginView()
        .environment(registrationViewModel)
}
