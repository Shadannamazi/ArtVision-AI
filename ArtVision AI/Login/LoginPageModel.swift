//
//  LoginPageModel.swift
//  ArtVision AI
//
//  Created by Shadan Namazi on 2023-08-06.
//

import SwiftUI

class LoginPageModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    
    @Published var registerUser: Bool = false
    @Published var re_Enter_Password: String = ""
    @Published var showReEnterPassword: Bool = false
    
    @AppStorage("log_Status") var log_Status: Bool = false
    
    func Login() {
        
        withAnimation{
            log_Status = true
        }
    }
    
    func Register(){
        
        withAnimation{
            log_Status = true
        }
    }
    
    func ForgotPassword(){
        
    }
    
    
}
