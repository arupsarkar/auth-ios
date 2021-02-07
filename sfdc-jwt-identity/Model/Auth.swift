//
//  Auth.swift
//  sfdc-jwt-identity
//
//  Created by Arup Sarkar on 2/2/21.
//

import Foundation

struct Auth: Codable {
    let access_token: String
    let scope: String
    let instance_url: String
    let id: String
    let token_type: String
    
    enum CodingKeys: String, CodingKey {
        case access_token = "access_token"
        case scope = "scope"
        case instance_url = "instance_url"
        case id = "id"
        case token_type = "token_type"
    }
}
