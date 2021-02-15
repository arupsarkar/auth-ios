//
//  LoginView.swift
//  sfdc-jwt-identity
//
//  Created by Arup Sarkar on 2/10/21.
//

import SwiftUI

struct LoginView: View {
    // Get the background image from https://unsplash.com/t/nature
    
    @ObservedObject var authViewModel = AuthViewModel()
    @State private var showLogin = false
    @State var subject = ""
    @State var status = "Enter without fear, click Sign In !!!"
    @State var token: String? = ""
    @State var instance_url: String? = ""
    @State private var username = ""
    @State private var button_title = "Sign In"
    @State var timeRemaining = 10
    @State private var showingNewUserSignUpView = false
    @State private var isShowingHomeView = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    // This will store the subject, token and instance_url
    @AppStorage("subject") var subject_Store: String = "No subject"
    @AppStorage("token") var token_store: String = "No Token"
    @AppStorage("instance_url") var instanceUrl_Store: String = "No Instance URL"

    
    var body: some View {
        if(isShowingHomeView) {
            NavigationView {
                VStack {
                    NavigationLink(destination: HomePageView()) {
                        Text("My Contacts")
                            .font(.headline)
                            .fontWeight(.light)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.blue)
                            .cornerRadius(15.0)
                            .shadow(radius: 10.0, x: 20, y: 10)
                    }
                }// end of VStack
                .navigationBarTitle(Text("Home"))
            }
            .navigationViewStyle(StackNavigationViewStyle())
        } else {
            VStack(){
                Text("Welcome to zootopia !!!")
                    .font(.largeTitle).foregroundColor(Color.white)
                    .padding([.top, .bottom], 40)
                    .shadow(radius: 10.0, x: 20, y: 10)
                
                Image("zootopia-logo")
                    .resizable()
                    .frame(width: 250, height: 250)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10.0, x: 20, y: 10)
                    .padding(.bottom, 50)
                
                VStack(alignment: .leading, spacing: 15) {
                    if(!isShowingHomeView) {
                        TextField("Username", text: self.$username)
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(20.0)
                            .shadow(radius: 10.0, x: 20, y: 10)
                    }
                }
                .padding([.leading, .trailing], 27.5)

                if(!isShowingHomeView) {
                    Button(action: {
                        self.button_title = " Aye Aye Captain, on it !!!"
                        self.authViewModel.fetchAuthAttributes(subject: username, authCompletionHandler: { (auth, error) in
                            if let auth = auth {
                                print(" ux received access _token : \(auth.access_token) ")
                                self.token = auth.access_token
                                if(self.token != nil) {
                                    self.status = "Welcome Home !!!"
                                    self.button_title = "Welcome Home ->"
                                    self.token_store = auth.access_token
                                    self.instanceUrl_Store =  auth.instance_url
                                    self.subject_Store = username
                                    self.isShowingHomeView.toggle()

                                }else {
                                    print("Access token is nil")
                                }
                                
                            }

                        })
                    }) {
                        Text(self.button_title)
                            .font(.headline)
                            .fontWeight(.light)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.green)
                            .cornerRadius(15.0)
                            .shadow(radius: 10.0, x: 20, y: 10)
                    }.padding(.top, 50) //Button end
                }

                
                Spacer()
                HStack {
                    Text("Do not have an account ?")
                        .fontWeight(.regular)
                        .foregroundColor(Color.white)
                    
                    Button(action: {
                        print("Sign Up")
                        showingNewUserSignUpView.toggle()
                    }, label: {
                        Text("Sign Up")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                    })
                    .sheet(isPresented: $showingNewUserSignUpView) {
                        NewUserSignUpView()
                    }
                } //end of HStack
            }//end of VStack
            .background(
                Image("background-login")
                    .resizable()
                    //.aspectRatio(geometry.size, contentMode: .fill)
                    .overlay(TintOverlay().opacity(0.55))
                    .edgesIgnoringSafeArea(.all)
            )
            //Text("v1.0 : \(String((self.token?.suffix(4) ?? "No token")))")
            //Text("v1.0 : \(self.status)")
        }
        } //end if

}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct TintOverlay: View {
    var body: some View {
        ZStack {
            Text(" ")
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        //.background(Color.black)
        .background(
            LinearGradient(gradient: Gradient(colors: Color.gradient), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
    }
}

struct NewUserSignUpView: View {
    @State private var Email = ""
    @State private var Fname = ""
    @State private var Lname = ""
    @State private var response = ""
    @State private var signUpButtonDisabled = false
    @ObservedObject var userViewModel = UserViewModel()
    
    var body: some View {
        
        VStack() {
            Text("Fasten your seatbelt, ready to launch !!!")
                .font(.title).foregroundColor(Color.white)
                .padding([.top, .bottom], 40)
                .shadow(radius: 10.0, x: 20, y: 10)
            
            VStack(alignment: .leading, spacing: 15) {
                
                TextField("Email", text: self.$Email)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                
                TextField("Firstname", text: self.$Fname)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                
                TextField("Lastname", text: self.$Lname)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
            }// end of VStack
            .padding([.leading, .trailing, .top], 40)
            Button(action: {
                print("Sign Up")
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
                self.userViewModel.register(userModel: newUser, registerCompletionHandler: {(resp, error) in
                    if let resp = resp {
                        print(" ux received record id : \(resp.record_id) ")
                        if(!resp.record_id.isEmpty) {
                            self.response = resp.record_id
                            self.signUpButtonDisabled.toggle()
                        }
                    }
                })
            }, label: {
                Text("Sign Up")
                    .font(.headline)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.green)
                    .cornerRadius(15.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
            })
            .padding([.top, .trailing], 30)
            .disabled(signUpButtonDisabled)
            Spacer()
            Text("After sign up, follow instructions in your email. {record_id : \(self.response)}")
                .frame(minWidth: 0, maxWidth: .infinity)
                .font(.system(size: 10))
                .padding()
                .foregroundColor(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 2)
                )
        }
        .background(
            Image("signup-image2")
                .resizable()
                //.aspectRatio(geometry.size, contentMode: .fill)
                .overlay(TintOverlay().opacity(0.75))
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
        )
    }
    
}
