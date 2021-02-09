//
//  AuthControllerAPI.swift
//  sfdc-jwt-identity
//
//  Created by Arup Sarkar on 2/2/21.
//

import Foundation
import Combine

enum AuthController {
    static let apiClient = APIClient()
    static let baseUrl = URL(string: "https://sfdc-jwt.herokuapp.com/")!
}


enum APIPath: String {
    case jwtToken = "jwt/token"
}

extension AuthController {
    
    static func request(_ path: APIPath) -> AnyPublisher<AuthResponse, Error> {
        guard var components = URLComponents(url: baseUrl.appendingPathComponent(path.rawValue), resolvingAgainstBaseURL: true)
            else { fatalError("Couldn't create URLComponents") }
        
        let request = URLRequest(url: components.url!)
        
        return apiClient.run(request) // 5
            .map(\.value) // 6
            .eraseToAnyPublisher() // 7
    }
}
