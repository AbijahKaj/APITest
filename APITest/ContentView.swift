//
//  ContentView.swift
//  APITest
//
//  Created by admin on 20.02.2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var settings: UserSettings
    
    var body: some View {
        if settings.token != ""{
            return AnyView(ProfileView(token: settings.token ))
        }else {
            return AnyView(LoginView())
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
