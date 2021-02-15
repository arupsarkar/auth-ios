//
//  AuthViewModel.swift
//  sfdc-jwt-identity
//
//  Created by Arup Sarkar on 2/2/21.
//
import Foundation
import Combine

class AuthViewModel: ObservableObject {
//    private let url = "https://sfdc-jwt.herokuapp.com/jwt/token"
    private var task: AnyCancellable?
    
    @Published var auth: [AuthModel] = []
    @Published var access_token: String?
    @Published var scope: String?
    @Published var instance_url: String?
    @Published var id: String?
    @Published var token_type: String?
    
    func fetchAuthAttributes(subject: String, authCompletionHandler: @escaping (AuthModel?, Error?) -> Void ) {
        var registerURL: String
        registerURL = "https://sfdc-jwt.herokuapp.com/jwt/sfdc-token?subject=" + subject
        let url = URL(string: registerURL)!
        print("Starting to fetch auth credentials for \(subject)")
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data else { return }
            print("response from server \(data)")
            do {
                let decoder = JSONDecoder()
                let jsonDict = try decoder.decode(AuthModel.self, from: data)
                authCompletionHandler(jsonDict, nil)
            } catch let parseErr {
                print("JSON Parsing Error", parseErr)
                authCompletionHandler(nil, parseErr)
            }

        })
        task.resume()
    }
    
//    func getAuthCredentials(subject: String) {
//        var registerURL: String
//        registerURL = "https://sfdc-jwt.herokuapp.com/jwt/sfdc-token?subject=" + subject
//        print("Starting to fetch auth credentials for \(subject)")
//        task = URLSession.shared.dataTaskPublisher(for: URL(string: registerURL)!)
//            .tryMap() { element -> Data in
//                guard let httpResponse = element.response as? HTTPURLResponse,
//                    httpResponse.statusCode == 200 else {
//                        throw URLError(.badServerResponse)
//                    }
//                return element.data
//                }
//            .receive(on: RunLoop.main)
//            .decode(type: AuthModel.self, decoder: JSONDecoder())
//            .sink(receiveCompletion: { print ("Received completion: \($0).") },
//                  receiveValue: {
//                    auth in print ("Received auth: \(auth).")
//                    self.access_token = auth.access_token
//                    self.instance_url = auth.instance_url
//                    self.token_store = auth.access_token
//                    self.instanceUrl_Store =  auth.instance_url
//                  })
//    }
}



