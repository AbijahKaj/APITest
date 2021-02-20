//
//  ServerHandler.swift
//  APITest
//
//  Created by admin on 20.02.2021.
//

import Foundation
import Combine
import Alamofire
import SwiftyJSON

class ServerHandler {
    
    @Published var loginResponse : LoginResponse?
    @Published var isLoading = false
    
    @Published var historyResponse = [History]()
    
    let url = "http://82.202.204.94/api/"
    
    func loginUser(username: String, password: String) {
        isLoading = true
        
        AF.request(url+"login", method: .post,
                   parameters: ["login" : username,
                                                    "password" : password],
                   headers: ["app-key": "12345", "v": "1"])
            .responseJSON {(responseData) -> Void in
                let jsonData = JSON(responseData.data as Any)
                print(jsonData)
                self.isLoading = false
                if let success = jsonData["success"].string {
                    self.loginResponse = LoginResponse(token: "", error: "")
                    if success == "true", let token = jsonData["response"]["token"].string{
                        self.loginResponse?.token = token
                    }else if let error = jsonData["error"]["error_msg"].string{
                        self.loginResponse?.error = error
                    }
                }
                
            
            }
    }
    func getHistory(token: String) -> [History] {
        isLoading = true
        
        AF.request(url+"payments?token=\(token)", method: .get,
                   headers: ["app-key": "12345", "v": "1"])
            .responseJSON {(responseData) -> Void in
                let jsonData = JSON(responseData.data as Any)
                print(jsonData)
                self.isLoading = false
                if let success = jsonData["success"].string {
                    if success == "true"{
                        for i in 0..<jsonData["response"].count{
                            
                            let arrayItem = jsonData["response"][i]
                            
                            if let created = arrayItem["created"].int,
                            let currency = arrayItem["currency"].string,
                            let amount = arrayItem["amount"].float,
                            let desc = arrayItem["desc"].string {
                                let payment = History(id: i, created: created, currency: currency, amount: amount, desc: desc)
                                self.historyResponse.append(payment)
                                print(payment)
                            }
                        }
                    }
                }
            }
        self.isLoading = false
        return self.historyResponse
    }
    
    
}
