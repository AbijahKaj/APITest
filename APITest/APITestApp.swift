//
//  APITestApp.swift
//  APITest
//
//  Created by admin on 20.02.2021.
//

import SwiftUI

@main
struct APITestApp: App {
    let settings = UserSettings()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(settings)
        }
    }
}
