//
//  LoginPage.swift
//  ArtVision AI
//
//  Created by Shadan Namazi on 2023-08-06.
//

import SwiftUI

struct LoginPage: View {
    @StateObject var loginData: LoginPageModel = LoginPageModel()
    @EnvironmentObject var profileManager: ProfileManager
    
    
    var body: some View {
        NavigationView {
            VStack{
                VStack{
                    
                    Text("Welcome back")
                        .font(.system(size: 60))
                        .foregroundColor(.white).bold().frame(maxWidth: .infinity,alignment: .leading)
                        .frame(height: UIScreen.main.bounds.height / 5)
                        .padding()
                }
                .frame(height: UIScreen.main.bounds.height / 5)
                
                ScrollView(.vertical, showsIndicators: false){
                    
                    VStack(spacing: 15){
                        
                        Text("Login")
                            .font(.system(size: 22)).bold()
                            .frame(maxWidth: .infinity,alignment: .leading)
                        
                        CustomtextFeild(icon: "person", title: "Username", hint: "yourUsername", value: $loginData.email, showPassword: .constant(false))
                            .padding(.top,30)
                        
                        CustomtextFeild(icon: "lock", title: "Password", hint: "123456", value: $loginData.password, showPassword: $loginData.showPassword)
                            .padding(.top,10)
                        
                        if loginData.registerUser{
                            
                            
                            
                            CustomtextFeild(icon: "lock", title: "Re-Enter Password", hint: "123456", value: $loginData.re_Enter_Password, showPassword: $loginData.showReEnterPassword)
                                .padding(.top,10)
                        }
                        
                        Button{
                        
                        } label:{
                            
                            Text("Forgot password?")
                                .font(.system(size: 14))
                                .foregroundColor(Color.black)
                        }
                        .padding(.top,8)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        
                        NavigationLink{
                            MainTab()
                                .environmentObject(profileManager)
                            
                        }label:{
                            
                            Text(loginData.registerUser ? "Register" :"Login")
                                .font(.system(size: 17))
                                .bold()
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical,20)
                                .background(Color.black)
                                .cornerRadius(15)
                        }
                        .navigationBarBackButtonHidden(true)
                        .padding(.top,10)
                        .padding(.horizontal)
                        
                        
//                        Button{
//                            if loginData.registerUser{
//                                loginData.Register()
//                            } else {
//                                loginData.Login()
//                            }
//                        } label:{
//
//                            Text(loginData.registerUser ? "Register" :"Login")
//                                .font(.system(size: 17))
//                                .bold()
//                                .foregroundColor(Color.white)
//                                .frame(maxWidth: .infinity)
//                                .padding(.vertical,20)
//                                .background(Color.black)
//                                .cornerRadius(15)
//                        }
//                        .padding(.top,10)
//                        .padding(.horizontal)
                        
                        
                        Button{
                            withAnimation{
                                loginData.registerUser.toggle()
                            }
                        } label:{
                            
                            Text(loginData.registerUser ? "Back to login" : "Create account")
                                .font(.system(size: 14))
                                .foregroundColor(Color.black)
                        }
                        .padding(.top,5)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        
                        
                    }.padding(30)
                    
                    
                }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                    .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))
                    .ignoresSafeArea()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .navigationBarBackButtonHidden(true)
            
        }
        .navigationBarHidden(true)
    }
    
    @ViewBuilder
    func CustomtextFeild(icon: String, title: String, hint: String, value: Binding<String>, showPassword: Binding<Bool>) -> some View{
        
        VStack(alignment: .leading, spacing: 12) {
            
            Label {
                Text(title)
                    .font(.system(size: 14)).bold()
                    
            } icon: {
                Image(systemName: icon)
            }
            .foregroundColor(Color.black.opacity(0.8))
            
            if title.contains("Password") && !showPassword.wrappedValue{
                SecureField(hint,text: value)
                    .padding(.top,2)
            } else{
                TextField(hint, text: value)
                    .padding(.top,2)
            }
            
            
            Divider()
                
        }
        
        .overlay(
            
            Group{
                
                if title.contains("Password") {
                    Button(action: {
                        showPassword.wrappedValue.toggle()
                    }, label: {
                        Text(showPassword.wrappedValue ? "Hide" : "Show")
                            .font(.system(size: 13))
                            .foregroundColor(.black)
                            .bold()
                    })
                    .offset( y: 8)
                    
                }
            }
            
            ,alignment: .trailing
        )
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
            .environmentObject(ProfileManager())
    }
}

