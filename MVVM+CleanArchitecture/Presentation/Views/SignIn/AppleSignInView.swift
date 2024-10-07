//
//  AppleSignInView.swift
//  MVVM+CleanArchitecture
//
//  Created by Aruna Udayanga on 07/10/2024.
//

import SwiftUI
import AuthenticationServices

struct AppleSignInView: View {
    @ObservedObject var viewModel = AppleSignInViewModel()

    var body: some View {
        VStack {
            if let user = viewModel.user {
                Text("Hello, \(user)")
            } else {
                SignInWithAppleButton(.signIn, onRequest: { request in
                    request.requestedScopes = [.fullName, .email]
                }, onCompletion: { result in
                    switch result {
                    case .success(let authResults):
                        print("Authorization successful!")
                    case .failure(let error):
                        print("Authorization failed: \(error.localizedDescription)")
                    }
                })
                .frame(width: 280, height: 45)
                .signInWithAppleButtonStyle(.black)
                .onTapGesture {
                    viewModel.handleAuthorization()
                }
            }
        }
    }
}
