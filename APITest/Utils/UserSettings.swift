//
//  UserSettings.swift
//  APITest
//
//  Created by admin on 20.02.2021.
//

import Foundation
class UserSettings: ObservableObject {
    @Published var token : String = UserDefaults.standard.string(forKey: "token") ?? ""
}
