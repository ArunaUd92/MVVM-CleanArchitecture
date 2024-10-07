//
//  AppleSignInViewModel.swift
//  MVVM+CleanArchitecture
//
//  Created by Aruna Udayanga on 07/10/2024.
//

import Foundation
import AuthenticationServices

class AppleSignInViewModel: NSObject, ObservableObject {
    @Published var user: String?

    func handleAuthorization() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
    }
}

extension AppleSignInViewModel: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName?.givenName ?? ""
            let email = appleIDCredential.email ?? ""

            // Save the userIdentifier in the app’s keychain or authentication system
            self.user = fullName.isEmpty ? email : fullName
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple Sign-In failed: \(error.localizedDescription)")
    }
}
