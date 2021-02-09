//
//  Auth.swift
//  sfdc-jwt-identity
//
//  Created by Arup Sarkar on 2/2/21.
//

import Foundation

struct AuthModel: Decodable, Hashable {
    public let access_token: String
    public let scope: String
    public let instance_url: String
    public let id: String
    public let token_type: String
}
