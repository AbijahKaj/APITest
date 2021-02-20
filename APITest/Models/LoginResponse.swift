//
//  LoginResponse.swift
//  APITest
//
//  Created by admin on 20.02.2021.
//

import Foundation
import CoreData

struct LoginResponse: Decodable, Equatable {
    
    var token: String?
    var error: String?
}

