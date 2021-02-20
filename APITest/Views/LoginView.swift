//
//  LoginView.swift
//  APITest
//
//  Created by admin on 20.02.2021.
//

import Foundation
import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel = LoginViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var settings: UserSettings
    
    
    var body: some View {
        VStack {
            VStack {
                Text("Welcome!")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.bottom, 20)
                VStack{
                    TextField("Username", text: $viewModel.username)
                        .autocapitalization(.none)
                        .padding()
                        .background(Theme.lightGreyColor)
                        .cornerRadius(Theme.radius * 0.5)
                        .padding(.bottom, 20)
                    SecureField("Password", text: $viewModel.password)
                        .padding()
                        .background(Theme.lightGreyColor)
                        .cornerRadius(Theme.radius * 0.5)
                        .padding(.bottom, 20)
                }.padding(20)
                VStack{
                    Text($viewModel.loginResponse.error.wrappedValue ?? "")
                        .font(.title3)
                        .fontWeight(.light)
                        
                }
                Button(action:
                        {
                            self.loginUser()
                        }, label: {
                    Text("LOGIN")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Theme.loginButton)
                        .cornerRadius(Theme.radius * 1.5)
                        })
                    
                
            }
            .onChange(of: self.viewModel.loginResponse.token){_ in
                setLoggedStatus()
            }
        }
    }
    func loginUser(){
        viewModel.loginUser()
    }
    func setLoggedStatus() {
        if(self.$viewModel.loginResponse.token.wrappedValue != ""){
            self.settings.token = self.$viewModel.loginResponse.token.wrappedValue ?? ""
            UserDefaults.standard.set(self.settings.token, forKey: "token")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
