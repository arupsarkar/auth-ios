//
//  AuthRowView.swift
//  sfdc-jwt-identity
//
//  Created by Arup Sarkar on 2/3/21.
//

import SwiftUI

struct AuthRowView: View {
    public let authRow: AuthModel
    
    init(authRow: AuthModel) {
        print("Staring AuthRowView init()")
        self.authRow = authRow
        print("Finished AuthRowView init()")
    }
    var body: some View {
        VStack {
            Text(authRow.access_token ?? "no access token")
        }
    }
}


//struct AuthRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthRowView()
//    }
//}
