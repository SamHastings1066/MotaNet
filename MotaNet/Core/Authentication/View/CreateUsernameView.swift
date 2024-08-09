//
//  CreateUsernameView.swift
//  MotaNet
//
//  Created by sam hastings on 09/08/2024.
//

import SwiftUI

struct CreateUsernameView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(RegistrationViewModel.self) private var viewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        VStack(spacing:12) {
            Text("Create username")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("This is the username for your account")
                .font(.footnote)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            TextField("Username", text: $viewModel.username)
                .textInputAutocapitalization(.none)
                .modifier(IGTextFieldModifier())
                .padding(.top)
            
            NavigationLink {
                CreatePasswordView()
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
        CreateUsernameView()
            .environment(registrationViewModel)
    }
}
