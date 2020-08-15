//
//  ContentView.swift
//  LoginPageEN
//
//  Created by TechReaderDongKey on 2020/08/12.
//  Copyright © 2020 TechReaderDongKey. All rights reserved.
//

import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0 )

let storedUsername : String = "dongkeydev"
let storedUserPassword : String = "dongkeydev"

struct LoginView: View {
    
    @State var username : String = ""
    @State var password : String = ""
    @State var email : String = ""
    @State var passwordCheck : String = ""
    
    @State var authenticationDidFailed: Bool = false
    @State var authenticationDidSucceed: Bool = false
    @State var index : Int = 0
    
    var body: some View {
        ZStack{ // View 위에 다른 뷰를 쌓는다 (중첩)
            VStack{ // 세로로 쌓는다. Hstack : 가로로 쌓는다
                
                Spacer()
                
                NoticeBoardTitle()
                userimage()
                
                Spacer()
                
                HStack{
                    Button(action : {
                        self.index = 0
                    }) {
                        Text("Existing")
                            .foregroundColor(self.index == 0 ? .black : .white)
                            .fontWeight(.bold)
                            .padding(.vertical, 10)
                            .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                    }.background(self.index == 0 ? Color.white : Color.clear)
                    .clipShape(Capsule())
                    
                    Button(action : {
                        self.index = 1
                    }) {
                        Text("New")
                            .foregroundColor(self.index == 1 ? .black : .white)
                            .fontWeight(.bold)
                            .padding(.vertical, 10)
                            .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                    }.background(self.index == 1 ? Color.white : Color.clear)
                    .clipShape(Capsule())
                }.background(Color.black.opacity(0.1))
                    .clipShape(Capsule())
                    .padding(.top , 25)
                
                
                if self.index == 0 {
                    
                    UsernameTextField(username: $username)
                    PasswordSecureField(password : $password)
                    if authenticationDidFailed {
                        Text("Information not correct. Try agian.")
                            .offset(y:-10)
                            .foregroundColor(.red)
                    }
                    
                    Spacer()
                    Spacer().frame(height : 47)
                                 
                    Button(action: {
                        if self.username == storedUsername && self.password == storedUserPassword{
                            self.authenticationDidSucceed = true
                        } else {
                            self.authenticationDidFailed = true
                        }
                    }){
                        LoginButtonContent()
                    }
                    
                } else {
                    UsernameTextField(username: $username)
                    PasswordSecureField(password : $password)
                    PasswordCheckField(passwordCheck : $passwordCheck)
                    
                  
                    
                    Button(action: {
                        if self.password != self.passwordCheck {
                            Text("Entered Password Different")
                                .font(.headline)
                                .frame(width: 250, height: 80)
                                .background(Color.gray)
                                .cornerRadius(20.0)
                            }
                    }){
                        SignUpButtonContent()
                    }
                    
                }
                
            }
            .padding()
            if authenticationDidSucceed {
                Text("Login Succeeded")
                    .font(.headline)
                    .frame(width: 250, height: 80)
                    .background(Color.green)
                    .cornerRadius(20.0)
                    .animation(Animation.default)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct NoticeBoardTitle: View {
    var body: some View {
        Text("NoticeBoard")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .frame(width : 200 , height: 30)
            .padding(.bottom, 20)
            
    }
}
struct userimage: View {
    var body: some View{
        Image("userimage")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(150)
            .padding(.bottom, 75)
    }
}

struct LoginButtonContent: View {
    var body: some View {
        Text("LOGIN")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width : 220, height : 60)
            .background(Color.black)
            .cornerRadius(30.0)
            .padding(.bottom, 20)
    }
}
    
struct SignUpButtonContent: View {
    var body: some View {
        Text("SignUp")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width : 220, height : 60)
            .background(Color.black)
            .cornerRadius(30.0)
            .padding(.bottom, 20)
    }
}

struct UsernameTextField: View {
    
    @Binding var username : String
    
    var body: some View {
        TextField("Username", text: $username)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

struct PasswordSecureField: View {
    
    @Binding var password : String
    
    var body: some View {
        SecureField("Password", text: $password)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}
    
struct PasswordCheckField: View {
    
    @Binding var passwordCheck : String
    
    var body: some View {
        SecureField("Password Check", text: $passwordCheck)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}
