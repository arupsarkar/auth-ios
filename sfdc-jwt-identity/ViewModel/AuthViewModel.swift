//
//  AuthViewModel.swift
//  sfdc-jwt-identity
//
//  Created by Arup Sarkar on 2/2/21.
//
import SwiftUI
import Foundation
import Combine

class AuthViewModel: ObservableObject {
    private let url = "https://sfdc-jwt.herokuapp.com/jwt/token"
    private var task: AnyCancellable?
    
    @Published var auth: [AuthModel] = []
    @Published var access_token: String?
    @Published var scope: String?
    @Published var instance_url: String?
    @Published var id: String?
    @Published var token_type: String?
    
    @AppStorage("token") var token_store: String = "No Token"
    @AppStorage("instance_url") var instanceUrl_Store: String = "No Instance URL"

    
    func getAuthCredentials() {
        print("Starting to fetch auth credentials")
        task = URLSession.shared.dataTaskPublisher(for: URL(string: url)!)
//            .map {
//                $0.data
//            }
//            .decode(type: AuthModel.self, decoder: JSONDecoder())
//            .replaceError(with: [])
//            .receive(on: RunLoop.main)
//            .eraseToAnyPublisher()
//            .assign(to: \AuthViewModel.auth, on: self)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                return element.data
                }
            .receive(on: RunLoop.main)
            .decode(type: AuthModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { print ("Received completion: \($0).") },
                  receiveValue: {
                    auth in print ("Received auth: \(auth).")
                    self.access_token = auth.access_token
                    self.instance_url = auth.instance_url
                    self.token_store = auth.access_token
                    self.instanceUrl_Store =  auth.instance_url
                  })



    }
}



