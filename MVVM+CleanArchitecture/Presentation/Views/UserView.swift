//
//  UserView.swift
//  DestinyGuide
//
//  Created by Aruna Udayanga on 25/06/2024.
//

import SwiftUI

struct UserView: View {
    @StateObject private var reachabilityManager = NetworkReachabilityManager()
    @StateObject private var viewModel = UserViewModel(
        fetchUsersUseCase: FetchUsersUseCaseImpl(userRepository: UserRepositoryImpl()),
        coreDataRepository: CoreDataUserRepository()
    )
    @StateObject private var coordinator = UserCoordinator()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(1.5, anchor: .center)
                        .padding(.top, 50)
                } else {
                    
                    if !reachabilityManager.isConnected {
                         Text("No Internet Connection")
                             .font(.headline)
                             .foregroundColor(.white)
                             .padding()
                             .background(Color.red)
                             .cornerRadius(8)
                             .padding(.top, 10)
                     }
                    
                    List(viewModel.users) { user in
                        Button(action: {
                            viewModel.selectUser(user)
                        }) {
                            HStack {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.blue)
                                    .padding(.trailing, 10)
                                
                                VStack(alignment: .leading) {
                                    Text(user.name)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    Text(user.email)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.vertical, 8)
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    .navigationTitle("Users")
                    .toolbar {
                         ToolbarItem(placement: .navigationBarTrailing) {
                             Button("Save") {
                                 viewModel.saveUsers()
                             }
                         }
                     }
                    .background(
                        NavigationLink(destination: UserDetailView(user: coordinator.selectedUser ?? User(id: 0, name: "", email: "")), isActive: $coordinator.isShowingDetailView) {
                            EmptyView()
                        }
                        .hidden()
                    )
                }
            }
            .onAppear {
                viewModel.delegate = coordinator
                reachabilityManager.onConnected = {
                    viewModel.fetchUsers()
                }
            }
            .alert(item: $viewModel.errorMessage) { error in
                Alert(
                    title: Text("Error"),
                    message: Text(error.message),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
