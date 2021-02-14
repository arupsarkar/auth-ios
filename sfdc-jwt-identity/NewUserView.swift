//
//  NewUserView.swift
//  sfdc-jwt-identity
//
//  Created by Arup Sarkar on 2/7/21.
//

import SwiftUI

struct NewUserView: View {
    @State var token: String
    @State var instance_url: String
    let userDefaults = UserDefaults.standard
    @ObservedObject var userViewModel = UserViewModel()
    @ObservedObject var authViewModel = AuthViewModel()
    @State var Email = "email value"
    @State var Fname = ""
    @State var Lname = ""
    @State var Alias = ""
    @State var TimezoneSidKey = "America/New_York"
    @State var LocaleSidKey = "en_US"
    @State var EmailEncodingKey = "ISO-8859-1"
    @State var LanguageLocaleKey = "en_US"
    @State var ProfileId = "00ef4000001zcgWAAQ"
    @State var userModel: UserModel!
    
    var body: some View {

        VStack {
            HStack {
                Text("Email")
                    .font(.headline)
                    .fontWeight(.light)
                    .foregroundColor(Color.init(.label))
                    .opacity(0.75)
                
                TextField("Enter your email", text: $Email)
            }
            HStack {
                Text("First Name")
                    .font(.headline)
                    .fontWeight(.light)
                    .foregroundColor(Color.init(.label))
                    .opacity(0.75)
                
                TextField("Enter your First Name", text: $Fname)
            }
            HStack {
                Text("Last Name")
                    .font(.headline)
                    .fontWeight(.light)
                    .foregroundColor(Color.init(.label))
                    .opacity(0.75)
                
                TextField("Enter your Last Name", text: $Lname)
            }
            Divider()
            Button(action: {
                print("Sign Up")
                print(self.token)
                print(self.Email)
                self.token = UserDefaults.standard.string(forKey: "token") ?? "No Token"
                self.instance_url = UserDefaults.standard.string(forKey: "instance_url") ?? "No URL"
                let newUser = UserModel (
                    Username: self.Lname + "." + self.Fname + "+123@example.com",
                    Lastname: self.Lname,
                    Firstname: self.Fname,
                    Email: self.Email,
                    Alias: self.Lname + "." + self.Fname + "1",
                    TimezoneSidKey: "America/New_York",
                    LocaleSidKey: "en_US",
                    EmailEncodingKey: "ISO-8859-1",
                    LanguageLocaleKey: "en_US",
                    ProfileId: "00ef4000001zcgWAAQ"
                )
//                self.userModel.Firstname = self.Fname
//                self.userModel.Lastname = self.Lname
//                self.userModel.Username = self.Lname + "." + self.Fname + "+123@example.com"
//                self.userModel.Alias = self.Lname + "." + self.Fname + "1"
//                self.userModel.EmailEncodingKey = "ISO-8859-1"
//                self.userModel.LanguageLocaleKey = "en_US"
//                self.userModel.LocaleSidKey = "en_US"
//                self.userModel.TimezoneSidKey = "America/New_York"
//                self.userModel.ProfileId = "00ef4000001zcgWAAQ"
//                // call the egister function
                self.userViewModel.registerNewUser(userModel: newUser, token: self.token, instance_url: self.instance_url)
            }, label: {
                Text("Sign Up")
                    .fontWeight(.light)
                    .font(.title)
            })
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(30)
        }

            Image("background-login")
                .clipShape(Circle())
                .shadow(radius: 10)
                .overlay(Circle().stroke(Color.red, lineWidth: 5))
    }
}

struct NewUserView_Previews: PreviewProvider {    
    @State static var token = ""
    @State static var instance_url = ""
    static var previews: some View {
        NewUserView(token: token, instance_url: instance_url)
    }
}
