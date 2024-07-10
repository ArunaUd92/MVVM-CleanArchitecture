//
//  UserDetailView.swift
//  MVVM+CleanArchitecture
//
//  Created by Aruna Udayanga on 10/07/2024.
//

import SwiftUI

struct UserDetailView: View {
    var user: User

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Adding a profile image
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
                .padding(.bottom, 16)

            Text(user.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding(.bottom, 8)

            Text(user.email)
                .font(.title2)
                .foregroundColor(.secondary)
                .padding(.bottom, 16)

            // Adding some additional information or a placeholder for further user details
            VStack(alignment: .leading, spacing: 8) {
                Text("Additional Information")
                    .font(.headline)
                    .foregroundColor(.primary)

                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent commodo cursus magna, vel scelerisque nisl consectetur et.")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)

            Spacer()
        }
        .padding()
        .navigationTitle("User Details")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemBackground))
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserDetailView(user: User(id: 1, name: "John Doe", email: "john.doe@example.com"))
        }
    }
}
