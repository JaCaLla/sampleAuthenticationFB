import SwiftUI
import FirebaseAuth

struct ForgotPasswordView: View {
    @State private var email = ""
    @State private var message = ""
    @State private var showAlert = false

    @StateObject var authenticationManager = AuthenticationManager.shared
    var body: some View {
        VStack(spacing: 20) {
            Text("Recuperar contraseña")
                .font(.largeTitle)

            TextField("Correo electrónico", text: $email)
                .autocapitalization(.none)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Enviar enlace de recuperación") {
                Task {
                    await authenticationManager.sendPasswordReset(email: email)
                    showAlert = true
                }
                
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)

            Text(message)
                .foregroundColor(.red)
                .padding()

            Spacer()
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Recuperación de contraseña"),
                  message: Text(message),
                  dismissButton: .default(Text("OK")))
        }
    }
}
