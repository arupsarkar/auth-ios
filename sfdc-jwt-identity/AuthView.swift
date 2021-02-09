//
//  ContentView.swift
//  sfdc-jwt-identity
//
//  Created by Arup Sarkar on 2/2/21.
//

import SwiftUI

struct AuthView: View {
    
    @ObservedObject var authViewModel = AuthViewModel()
    @State private var showLogin = false
    @State var token: String? = ""
    @State var instance_url: String? = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("access_token : ")
                Text(authViewModel.access_token ?? "No Token")
            }
            HStack {
                Text("instance_url : ")
                Text(authViewModel.instance_url ?? "No instance url")
            }

            VStack {
                Button(action: {
                    print("Login")
                    self.authViewModel.getAuthCredentials()
                    if authViewModel.access_token != nil {
                        self.token = authViewModel.access_token ?? "No Token"
                        self.instance_url = authViewModel.instance_url ?? "No Instance URL"
                        self.showLogin.toggle()
                    }
                }, label: {
                    Text("Get Token")
                        .fontWeight(.light)
                        .font(.title)
                })
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(30)
                .disabled(showLogin)
                
                NavigationView {
                    NavigationLink(destination: NewUserView(token: self.token!, instance_url: self.instance_url!)) {
                      Text("Sign Up")
                   }.buttonStyle(DefaultButtonStyle())
                }

            }
        }
    }
    
}

struct AuthView_Previews: PreviewProvider {
    @Binding var newUserSignUp: Bool
    static var previews: some View {
        AuthView()
    }
}
