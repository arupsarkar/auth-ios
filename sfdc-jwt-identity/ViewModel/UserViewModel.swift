//
//  UserViewModel.swift
//  sfdc-jwt-identity
//
//  Created by Arup Sarkar on 2/7/21.
//

import Foundation
import Combine


class UserViewModel: ObservableObject {
    @Published var newUserCreated: Bool?
    @Published var record_id: String?
    @Published var userResponse: [UserResponse] = []
    private var task: AnyCancellable?


    
    func registerNewUser(userModel: UserModel, token: String, instance_url: String) {
        print("Starting to create new User")
        print("token : \(token)")
        print("instance_url : \(instance_url)")
        print("NEW USER EMAIL : \(userModel.Email)")
        var registerURL: String
        registerURL = "https://sfdc-jwt.herokuapp.com/jwt/register?token=" + token + "&instance_url=" + instance_url
        let url = URL(string: registerURL)
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let userRecord = UserModel(Username: userModel.Username, Lastname: userModel.Lastname, Firstname: userModel.Firstname, Email: userModel.Email, Alias: userModel.Alias, TimezoneSidKey: userModel.TimezoneSidKey, LocaleSidKey: userModel.LocaleSidKey, EmailEncodingKey: userModel.EmailEncodingKey, LanguageLocaleKey: userModel.LanguageLocaleKey, ProfileId: userModel.ProfileId)
        
        let jsonData = try? JSONEncoder().encode(userRecord)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error took place \(error)")
                return
            }
            guard let data = data else {return}
            do {
                let userResponseModel = try JSONDecoder().decode(UserResponse.self, from: data)
                print("Response data:\n \(userResponseModel)")
            }catch let jsonErr{
                print(jsonErr)
            }

        }
        task.resume()
        
//        task = URLSession.shared.dataTaskPublisher(for: URL(string: url)!)
//            .tryMap() { element -> Data in
//                guard let httpResponse = element.response as? HTTPURLResponse,
//                    httpResponse.statusCode == 200 else {
//                        throw URLError(.badServerResponse)
//                    }
//                return element.data
//                }
//            .receive(on: RunLoop.main)
//            .decode(type: UserResponse.self, decoder: JSONDecoder())
//            .sink(
//                receiveCompletion: {
//                    print ("Received completion: \($0).")
//                    if(self.record_id != nil) {
//                        self.newUserCreated = true
//                    }
//                },
//                receiveValue: {
//                    userResponse in print ("Received auth: \(userResponse).")
//                    self.record_id = userResponse.record_id
//
//                }
//            )
    } //end of func
}



