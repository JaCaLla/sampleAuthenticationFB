//
//  ContentView.swift
//  sampleAuthenticationFB
//
//  Created by Javier Calatrava on 23/11/24.
//

import SwiftUI

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @StateObject var authenticationManager = AuthenticationManager.shared
    var body: some View {
        ZStack {
            Color(authenticationManager.isUserLoggedIn ? .green : .red)
            LoginView()
        }
        
    }
}



#Preview {
    ContentView()
}
