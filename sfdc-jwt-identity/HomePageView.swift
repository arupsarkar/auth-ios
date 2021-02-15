//
//  HomePageView.swift
//  sfdc-jwt-identity
//
//  Created by Arup Sarkar on 2/14/21.
//

import SwiftUI

struct HomePageView: View {
    
    // Refernce: https://www.answertopia.com/swiftui/a-swiftui-list-and-navigation-tutorial/
    // Reference: https://morioh.com/p/a9459811c4a8
    
    @State private var token = ""
    @State private var instance_url = ""
    @ObservedObject var contactsVidelModel = ContactsViewModel()
    @State var records: [ContactModel] = []
    
    var body: some View {
        VStack{
            Text("Contact Records")
            List(self.records) { contact in
                VStack {
                    Text("\(contact.LastName)" + ", \(contact.FirstName ?? "")" )
                        .font(.title2)
                    Text("Phone : \(contact.MobilePhone ?? "")")
                    Text("Email : \(contact.Email ?? "")")
                }
                .padding([.leading, .trailing], 10)
            }
            
        }
        .onAppear(perform: {
            print("Contact View Loaded")
            self.token = UserDefaults.standard.string(forKey: "token") ?? "No Token"
            self.instance_url = UserDefaults.standard.string(forKey: "instance_url") ?? "No URL"
            print("token \(self.token)")
            print("instance url \(self.instance_url)")
            self.contactsVidelModel.getContacts(token: self.token, instance_url: self.instance_url, contactCompletionHandler: { (contacts, error) in
                
                if contacts != nil {
                    self.records = contacts!
                    for contact in self.records {
                        print("First Name : \(contact.FirstName ?? "No First Name")")
                    }
                }
                
            })
        })
        
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
