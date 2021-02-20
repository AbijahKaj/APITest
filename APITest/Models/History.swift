//
//  User.swift
//  APITest
//
//  Created by admin on 20.02.2021.
//

import Foundation


struct History: Identifiable {
    let id: Int?
    
    let created: Int
    let currency: String
    let amount: Float
    let desc: String
}
