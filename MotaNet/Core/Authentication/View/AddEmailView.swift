//
//  AddEmailView.swift
//  MotaNet
//
//  Created by sam hastings on 09/08/2024.
//

import SwiftUI

struct AddEmailView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(RegistrationViewModel.self) private var viewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        VStack(spacing:12) {
            Text("Add your email")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("You'll use this email to sign into your account")
                .font(.footnote)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            TextField("Email", text: $viewModel.email)
                .textInputAutocapitalization(.none)
                .modifier(IGTextFieldModifier())
                .padding(.top)
            
            NavigationLink {
                CreateUsernameView()
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
        AddEmailView()
            .environment(registrationViewModel)
    }
}
