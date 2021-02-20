//
//  LoginViewModel.swift
//  APITest
//
//  Created by admin on 20.02.2021.
//

import Foundation
import SwiftUI
import Combine

class LoginViewModel: ObservableObject, Identifiable {
    
    @Published var username = ""
    @Published var password = ""
    
    @Published var isLoggedIn = false
    @Published var isLoading = false
    
    @Published var shouldNavigate = false
    
    private var disposables: Set<AnyCancellable> = []
    
    var loginHandler = ServerHandler()
    
    @Published var loginResponse = LoginResponse(token: "", error: "")
    
    private var isLoadingPublisher: AnyPublisher<Bool, Never> {
        loginHandler.$isLoading
            .receive(on: RunLoop.main)
            .map { $0 }
            .eraseToAnyPublisher()
    }
    
    private var isAuthenticatedPublisher: AnyPublisher<LoginResponse, Never> {
        loginHandler.$loginResponse
            .receive(on: RunLoop.main)
            .map { response in
                guard let response = response else {
                    return LoginResponse(token: "", error: "")
                }
                
                return response
        }
        .eraseToAnyPublisher()
    
    }
    
    init() {
        isLoadingPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: self)
            .store(in: &disposables)
        
        isAuthenticatedPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.loginResponse, on: self)
            .store(in: &disposables)
        
    }
    
    func loginUser() {
        loginHandler.loginUser(username: self.username, password: self.password)
    }
    
}
