//
//  ProfileViewModel.swift
//  APITest
//
//  Created by admin on 20.02.2021.
//

import Foundation
import Combine

class ProfileViewModel : ObservableObject, Identifiable{
    @Published var history = [History]()
    @Published var isLoading = false
    
    
    var loaderHandler = ServerHandler()
    private var disposables: Set<AnyCancellable> = []
    
    private var isLoadingPublisher: AnyPublisher<Bool, Never> {
        loaderHandler.$isLoading
            .receive(on: RunLoop.main)
            .map { $0 }
            .eraseToAnyPublisher()
    }
    private var isGettingPaymentHistory: AnyPublisher<[History], Never> {
        loaderHandler.$historyResponse
            .receive(on: RunLoop.main)
            .map { response in
                return response
        }
        .eraseToAnyPublisher()
    
    }
    init() {
        isLoadingPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: self)
            .store(in: &disposables)
        isGettingPaymentHistory
            .receive(on: RunLoop.main)
            .assign(to: \.history, on: self)
            .store(in: &disposables)
    }
    func getPaymentsHistory(token: String){
        let history = loaderHandler.getHistory(token: token)
        self.history.append(contentsOf: history)
    }
    func signoutUser(){
        UserDefaults.standard.set("", forKey: "token")
    }
}
