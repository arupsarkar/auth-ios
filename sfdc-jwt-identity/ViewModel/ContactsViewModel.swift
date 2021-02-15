//
//  ContactsViewModel.swift
//  sfdc-jwt-identity
//
//  Created by Arup Sarkar on 2/14/21.
//

import Foundation
import Combine


class ContactsViewModel: ObservableObject {
    func getContacts(token: String, instance_url: String, contactCompletionHandler: @escaping ([ContactModel]?, Error?) -> Void ) {
        
        var registerURL: String
        registerURL = "https://sfdc-jwt.herokuapp.com/contacts?access_token=" + token + "&instance_url=" + instance_url
        let url = URL(string: registerURL)!
        print("\(url)")
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data else { return }
            print("response from server \(data)")
            do {
                let decoder = JSONDecoder()
                let jsonDict = try decoder.decode([ContactModel].self, from: data)
                contactCompletionHandler(jsonDict, nil)
            } catch let parseErr {
                print("JSON Parsing Error", parseErr)
                contactCompletionHandler(nil, parseErr)
            }
        })
        task.resume()
        
    }
}

