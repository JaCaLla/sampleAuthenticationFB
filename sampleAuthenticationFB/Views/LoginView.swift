//
//  LoginView.swift
//  sampleAuthenticationFB
//
//  Created by Javier Calatrava on 24/11/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    @StateObject var authenticationManager = AuthenticationManager.shared
    
    var body: some View {
        VStack(spacing: 20) {
            if authenticationManager.isUserLoggedIn {
                Text("¡Bienvenido!")
                    .font(.largeTitle)
                Button("Cerrar sesión") {
                    Task {
                        await authenticationManager.logoutUser()
                    }
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)
            } else {
                Text("Firebase Auth")
                    .font(.largeTitle)
                TextField("Correo electrónico", text: $email)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("Contraseña", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Registrarse") {
                    Task {
                        await authenticationManager.registerUser(email: email, password: password)
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)

                Button("Iniciar sesión") {
                    Task {
                        await                     authenticationManager.loginUser(email: email, password: password)
                    }
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)

                Text(authenticationManager.message)
                    .foregroundColor(.black)
                    .padding()
                
                NavigationLink("¿Olvidaste tu contraseña?", destination: ForgotPasswordView())
                    .padding()
                    .foregroundColor(.blue)
            }
        }
        .padding()
    }

    // Funciones de autenticación
}

#Preview {
    LoginView()
}
