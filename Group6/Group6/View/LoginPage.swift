//
//  LoginPage.swift
//  Group6
//
//  Created by Alessandro Capodanno on 23/02/22.
//

import Foundation

import SwiftUI

struct LoginPage: View {
    @StateObject var loginData: LoginPageModel = LoginPageModel()
    var body: some View {
        
        VStack{
            
            // WElcome Back text for 3 half of the screen...
            Text("Welcome\nback")
                .font(.custom(customFont, size: 55).bold())
                .foregroundColor(.white)
                .frame(maxWidth: .infinity,alignment: .leading)
                .frame(height: getRect().height / 5.4)
                .padding()
                .background(
                
                    ZStack{
                        
                        // Gradient Circle...
                        LinearGradient(colors: [
                        
                            Color("AccentColor"),
                            Color("AccentColor")
                                .opacity(1),
                            Color("AccentColor")
                        ], startPoint: .top, endPoint: .bottom)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                            .padding(.trailing)
                            .offset(y: -25)
                            .ignoresSafeArea()
                        
                        Circle()
                            .strokeBorder(Color.white.opacity(0.3),lineWidth: 3)
                            .frame(width: 30, height: 30)
                            .blur(radius: 2)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                            .padding(30)
                        
                        Circle()
                            .strokeBorder(Color.white.opacity(0.3),lineWidth: 3)
                            .frame(width: 23, height: 23)
                            .blur(radius: 2)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .padding(.leading,30)
                    }
                )
            
            ScrollView(.vertical, showsIndicators: false) {
                
                // Login Page Form....
                VStack(spacing: 5){
                    
                    Text(loginData.registerUser ? "Register" : "Login")
                        .font(.custom(customFont, size: 22).bold())
                        .frame(maxWidth: .infinity,alignment: .leading)
                    
                    // Custom Text Field...
                    if loginData.registerUser{
                        CustomTextField(icon: "person", title: "Username", hint: "Enter Username", value: $loginData.username, showPassword: .constant(false))
                            .padding(.top,10)
                    }
                    CustomTextField(icon: "envelope", title: "Email", hint: "Enter Email", value: $loginData.email, showPassword: .constant(false))
                        .padding(.top,10)
                    CustomTextField(icon: "lock", title: "Password", hint: "Enter Password", value: $loginData.password, showPassword: $loginData.showPassword)
                        .padding(.top,10)
                    if loginData.registerUser{
                        CustomTextField(icon: "lock", title: "Re-Enter Password", hint: "Enter Password", value: $loginData.re_Enter_Password, showPassword: $loginData.showReEnterPassword)
                            .padding(.top,10)
                    }
                    if !loginData.registerUser{
                    Button {
                        loginData.ForgotPassword()
                    } label: {
                        
                        Text("Forgot password?")
                            .font(.custom(customFont, size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("AccentColor"))
                    }
                    .padding(.top,8)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    }
                    Button {
                        if loginData.registerUser{
                            loginData.Register()
                        }
                        else{
                            loginData.Login()
                        }
                    } label: {
                        
                        Text(loginData.registerUser ? "Create account" :"Login")
                            .font(.custom(customFont, size: 17).bold())
                            .padding(.vertical,20)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color("AccentColor"))
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.07), radius: 5, x: 5, y: 5)
                    }
                    .padding(.top,25)
                    .padding(.horizontal)
                    Button {
                        withAnimation{
                            loginData.registerUser.toggle()
                        }
                    } label: {
                        
                        Text(loginData.registerUser ? "Back to login" : "Create account")
                            .font(.custom(customFont, size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("AccentColor"))
                    }
                    .padding(.top,8)
                }
                .padding(30)
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(
                Color.white
                    .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))
                    .ignoresSafeArea()
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("AccentColor"))
        .onChange(of: loginData.registerUser) { newValue in
            
            loginData.email = ""
            loginData.password = ""
            loginData.re_Enter_Password = ""
            loginData.showPassword = false
            loginData.showReEnterPassword = false
        }
    }
    
    @ViewBuilder
    func CustomTextField(icon: String,title: String,hint: String,value: Binding<String>,showPassword: Binding<Bool>)->some View{
        
        VStack(alignment: .leading, spacing: 12) {
            
            Label {
                Text(title)
                    .font(.custom(customFont, size: 14))
            } icon: {
                Image(systemName: icon)
            }
            .foregroundColor(Color.black.opacity(0.8))
            
            if title.contains("Password") && !showPassword.wrappedValue{
                SecureField(hint, text: value)
                    .padding(.top,2)
            }
            else{
                TextField(hint, text: value)
                    .padding(.top,2)
            }
            
            Divider()
                .background(Color.black.opacity(0.4))
        }
        // Showing Show Button for password Field...
        .overlay(
        
            Group{
                
                if title.contains("Password"){
                    Button(action: {
                        showPassword.wrappedValue.toggle()
                    }, label: {
                        Text(showPassword.wrappedValue ? "Hide" : "Show")
                            .font(.custom(customFont, size: 13).bold())
                            .foregroundColor(Color("Purple"))
                    })
                    .offset(y: 8)
                }
            }
            
            ,alignment: .trailing
        )
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
