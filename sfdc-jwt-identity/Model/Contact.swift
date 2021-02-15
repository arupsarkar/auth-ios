//
//  Contact.swift
//  sfdc-jwt-identity
//
//  Created by Arup Sarkar on 2/14/21.
//

import Foundation


struct AttributesModel: Codable {
    public var type: String
    public var url: String
}

struct ContactModel: Codable, Identifiable {
    public var attributes: AttributesModel?
    public var id: String
    public var FirstName: String?
    public var LastName: String
    public var Email: String?
    public var MobilePhone: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case FirstName = "FirstName"
        case LastName = "LastName"
        case Email = "Email"
        case MobilePhone = "MobilePhone"
    }
}
