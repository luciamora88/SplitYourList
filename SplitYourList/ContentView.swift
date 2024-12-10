import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("SplitYourList")
                        .font(.largeTitle)
                        .bold()
                        .padding(.leading)
                    Spacer()
                }
               
                // Espaciador que empuja la parte inferior hacia arriba, reduciendo la distancia entre el título y los botones
                Spacer(minLength: 50) // Ajusta `minLength` según lo que necesites
               
                VStack(spacing: 20) {
                    NavigationLink(destination: LoginView()) {
                        Text("Login")
                            .font(.title2)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    Button("Test")
                    {
                        Task {
                            let db = Firestore.firestore()
                           // do {
                            try await print(db.collection("Groups").document("GroupID_0").getDocument().data() ?? "no");
//
                        }
                    }
                   
                    NavigationLink(destination: RegisterView()) {
                        Text("Register")
                            .font(.title2)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 40)
               
                Spacer() // Este `Spacer` mantiene la parte inferior flexible, empujando hacia arriba si es necesario
            }
        }
    }
}

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack(spacing: 20) {
                Text("Login")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)

            // Campo de texto para el correo electrónico
            VStack(alignment: .leading, spacing: 5) {
                Text("Email")
                    .font(.headline)
                TextField("Enter your email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
            }

            // Campo de texto para la contraseña
            VStack(alignment: .leading, spacing: 5) {
                Text("Password")
                    .font(.headline)
                SecureField("Enter your password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

            // Botón de login
//                Button(action: {
//                    // Acción al presionar el botón
//                    print("Login button pressed")
//                }) {
            NavigationLink(destination: GroupView()) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
                //}

            Spacer()
        }
        .padding()
        .navigationTitle("Login")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


struct RegisterView: View {
    
   
        @State private var name: String = ""
        @State private var email: String = ""
        @State private var password: String = ""
        @State private var confirmPassword: String = ""

        var body: some View {
            VStack(spacing: 20) {
                // Campo de texto para el nombre
                VStack(alignment: .leading, spacing: 5) {
                    Text("Name")
                        .font(.headline)
                    TextField("Enter your name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                // Campo de texto para el correo electrónico
                VStack(alignment: .leading, spacing: 5) {
                    Text("Email")
                        .font(.headline)
                    TextField("Enter your email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                }

                // Campo de texto para la contraseña
                VStack(alignment: .leading, spacing: 5) {
                    Text("Password")
                        .font(.headline)
                    SecureField("Enter your password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                // Campo de texto para confirmar la contraseña
                VStack(alignment: .leading, spacing: 5) {
                    Text("Password Confirmation")
                        .font(.headline)
                    SecureField("Confirm your password", text: $confirmPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                // Botón de registro
                NavigationLink(destination: GroupView()) {
//                    Button(action: {
//                        // Acción al presionar el botón
//                        print("Register button pressed")
//                    }) {
                        Text("Register")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .padding(.top, 20)
                //}
            }
            .padding()
        }
    }

    struct RegisterView_Previews: PreviewProvider {
        static var previews: some View {
            RegisterView()
        }
    }
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
