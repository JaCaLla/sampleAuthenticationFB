//
//  AuthenticationManager.swift
//  sampleAuthenticationFB
//
//  Created by Javier Calatrava on 23/11/24.
//

import Foundation
import SwiftUI
import FirebaseAuth

protocol AuthenticationManagerProtocol {
    func registerUser(email: String, password: String) async
    func loginUser(email: String, password: String) async
    func logoutUser() async
    func sendPasswordReset(email: String) async
}

@globalActor
actor GlobalManager {
    static var shared = GlobalManager()
}

@GlobalManager
final class AuthenticationManager: ObservableObject {

    @MainActor
    static let shared = AuthenticationManager()

    @MainActor
    @Published var isUserLoggedIn: Bool = false
    @MainActor
    @Published var message = ""

    private var isUserLoggedInInternal: Bool = false {
        didSet {
            Task {
                await MainActor.run { [isUserLoggedInInternal] in
                    isUserLoggedIn = isUserLoggedInInternal
                }
            }
        }
    }

    private var messageInternal: String = "" {
        didSet {
            Task {
                await MainActor.run { [messageInternal] in
                    message = messageInternal
                }
            }
        }
    }

    @MainActor
    private init() {
    }
}

extension AuthenticationManager: AuthenticationManagerProtocol {
    func set(loggedin: Bool) {
        isUserLoggedInInternal = loggedin
    }

    func set(message: String) {
        self.messageInternal = message
    }

    func registerUser(email: String, password: String) async {
        do {
            let _: () = try await Task.detached {
                _ = try await Auth.auth().createUser(withEmail: email, password: password)
            }.value

            set(message: "Usuario registrado con éxito")
            set(loggedin: true)
        } catch {
            set(message: "Error: \(error.localizedDescription)")
        }
    }

    func loginUser(email: String, password: String) async {
        do {
            let _: () = try await Task.detached {
                _ = try await Auth.auth().signIn(withEmail: email, password: password)
            }.value
            set(message: "Inicio de sesión exitoso")
            set(loggedin: true)
        } catch {
            set(message: "Error: \(error.localizedDescription)")
        }
    }

    func logoutUser() async {
        do {
            try Auth.auth().signOut()
            set(loggedin: false)
            set(message: "Sesión cerrada")
        } catch {
            set(message: "Error al cerrar sesión")
        }
    }

    func sendPasswordReset(email: String) async {
        do {
            _ = try await Auth.auth().sendPasswordReset(withEmail: email)
            set(message: "Se ha enviado un enlace de recuperación a tu correo electrónico.")
        } catch {
            set(message: "Error: \(error.localizedDescription)")
        }
    }
}
