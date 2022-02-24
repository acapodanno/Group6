//
//  LoginPageModel.swift
//  Group6
//
//  Created by Alessandro Capodanno on 23/02/22.
//

import Foundation
import SwiftUI

class LoginPageModel: ObservableObject {
    
    // Login Properties..
    var userApi:UserApi = UserApi()
    @Published var email: String = ""
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    
    // Register Properties
    @Published var registerUser: Bool = false
    @Published var re_Enter_Password: String = ""
    @Published var showReEnterPassword: Bool = false
    @AppStorage("id") var userId: Int = 0
    @AppStorage("log_Status") var log_Status: Bool = false
        
    
    // Login Call...
    func Login(){
        userApi.signin(email: email, password: password).id

        withAnimation{
                    log_Status = true
        }
    }
    
    func Register(){
        userApi.signup(username: username, email: email, password: password)
    }
    
    func ForgotPassword(){
        // Do Action Here...
    }
}
