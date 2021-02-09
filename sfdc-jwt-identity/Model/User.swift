//
//  User.swift
//  sfdc-jwt-identity
//
//  Created by Arup Sarkar on 2/7/21.
//

import Foundation

struct UserResponse: Decodable {
    public let record_id: String
}

struct UserModel: Codable {
    public var Username: String
    public var Lastname: String
    public var Firstname: String
    public var Email: String
    public var Alias: String
    public var TimezoneSidKey: String
    public var LocaleSidKey: String
    public var EmailEncodingKey: String
    public var LanguageLocaleKey: String
    public var ProfileId: String
}

// Sample User data attributes
// ---------------------------------
//"Username": "test+321@example.com",
//"Lastname": "testL2",
//"Email": "test2@example.com",
//"Alias": "testF2",
//"TimezoneSidKey": "America/New_York",
//"LocaleSidKey": "en_US",
//"EmailEncodingKey": "ISO-8859-1",
//"LanguageLocaleKey": "en_US",
//"ProfileId": "00ef4000001zcgWAAQ"
