



import SwiftUI

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
    var body: some View {
        Text("Login Page")
            .font(.largeTitle)
    }
}

struct RegisterView: View {
    var body: some View {
        Text("Register Page")
            .font(.largeTitle)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
