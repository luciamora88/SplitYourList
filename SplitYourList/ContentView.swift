import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("SplitYourList")
                        .font(.largeTitle)
                        .bold()
                        .padding(.leading)
                    Spacer()
                }

                // Spacer to reduce the distance between the title and the buttons
                Spacer(minLength: 50) // Adjust `minLength` as needed

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

                    Button("Test") {
                        Task {
                            let db = Firestore.firestore()
                            do {
                                let document = try await db.collection("Groups").document("GroupID_0").getDocument()
                                print(document.data() ?? "No data found")
                            } catch {
                                print("Error fetching document: \(error.localizedDescription)")
                            }
                        }
                    }
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)

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

                Spacer() // Keeps the bottom flexible
            }
        }
    }
}

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isNavigating = false
    @State private var isNotNavigating = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .font(.largeTitle)
                .bold()
                .padding(.top)

            // Email input field
            VStack(alignment: .leading, spacing: 5) {
                Text("Username")
                    .font(.headline)
                TextField("Enter your email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
            }

            // Password input field
            VStack(alignment: .leading, spacing: 5) {
                Text("Password")
                    .font(.headline)
                SecureField("Enter your password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

            // Login button
            VStack
            {
                Button("Login") {
                    Task {
                        let db = Firestore.firestore()
                        do {
                            let document = try await db.collection("User").document(email).getDocument()
                            if let DBPassword = document.data()?["Password"] as? String {
                                print("Password from DB: \(DBPassword)")
                                if(DBPassword == password)
                                {
                                    isNavigating = true
                                } else
                                {
                                    isNavigating = false
                                }
                            } else {
                                isNavigating = false
                            }
                        } catch {
                            print("Error fetching user: \(error.localizedDescription)")
                        }
                        isNotNavigating = !isNavigating
                    }
                }
            }
            .alert("Authentication Failed...", isPresented: $isNotNavigating)
            {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Authentication Failed...")
            }

            NavigationLink(destination: GroupView(), isActive: $isNavigating) {
                EmptyView()
            }
            .hidden()

            Spacer()
        }
        .padding()
    }
}

struct RegisterView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isNavigating = false
    @State private var isRegistered = false
    @State private var isNotRegistered = false
    
    
    var body: some View {
        VStack(spacing: 20) {
            // Name input field
            VStack(alignment: .leading, spacing: 5) {
                Text("Name")
                    .font(.headline)
                TextField("Enter your name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            // Email input field
            VStack(alignment: .leading, spacing: 5) {
                Text("Username")
                    .font(.headline)
                TextField("Enter your email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
            }
            
            // Password input field
            VStack(alignment: .leading, spacing: 5) {
                Text("Password")
                    .font(.headline)
                SecureField("Enter your password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            VStack
            {
                // Register button
                Button("Register") {
                    Task {
                        let db = Firestore.firestore()
                        do {
                            let document = try await db.collection("User").document(email).getDocument()
                            if let DBPassword = document.data()?["Password"] as? String {
                                print("Password from DB: \(DBPassword)")
                                isNavigating = true
                            } else {
                                isNavigating = false
                            }
                        } catch {
                            print("Error fetching user: \(error.localizedDescription)")
                        }
                        
                        if !isNavigating {
                            do {
                                try await db.collection("User").document(email).setData([
                                    "Password": password,
                                    "Groups": []
                                ])
                                isRegistered = false
                            } catch {
                                print("Error registering user: \(error.localizedDescription)")
                            }
                        } else {
                            isRegistered = true
                        }
                        
                        isNotRegistered = !isRegistered;
                    }
                }
            }
            .alert("Registration Failed...", isPresented: $isRegistered
            )
            {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Authentication Failed...")
            }
            
            NavigationLink(destination: GroupView(), isActive: $isNotRegistered) {
                EmptyView()
            }
            .hidden()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
