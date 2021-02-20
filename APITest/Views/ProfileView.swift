//
//  ProfileView.swift
//  APITest
//
//  Created by admin on 20.02.2021.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel = ProfileViewModel()
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var settings: UserSettings
    
    private let token: String
    let dateFormatter = DateFormatter()
    
    init(token: String) {
        self.token = token
        viewModel.getPaymentsHistory(token: token)
       
        dateFormatter.timeZone = NSTimeZone() as TimeZone?
        dateFormatter.locale = NSLocale.current 
        dateFormatter.dateFormat =  "MMMM dd, yyyy' at 'HH:mm"
    }
   
    var body: some View{
        NavigationView {
            VStack{
                List(viewModel.history){ i in
                    VStack{
                        
                        Text(String(i.desc))
                            .font(.headline)
                        
                        Spacer()
                        HStack{
                            Text("\(String(i.amount)) \(String(i.currency)) ")
                                .font(.title3)
                            Spacer()
                            Text("Made on \(dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(i.created))))")
                                .font(.system(size: 13))
                        }
                        
                        
                    }
                    .frame(height: 100)
                    .padding(10)
                }
                Spacer()
                Button(action: signoutUser) {
                    Text("SIGNOUT")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Theme.signoutButton)
                        .cornerRadius(Theme.radius * 1.5)
                    
                }.simultaneousGesture(TapGesture().onEnded{
                    self.signoutUser()
                })
            }
            .navigationBarTitle("Payment history")
        }
        
    }
    func signoutUser() {
        viewModel.signoutUser()
        self.settings.token = ""
    }
}
