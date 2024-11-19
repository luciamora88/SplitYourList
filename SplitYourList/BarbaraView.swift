import SwiftUI

struct InsideGroupView: View {
    @State private var lists: [String] = [] // Lista de listas creadas
    
    var body: some View {
        NavigationView {
            VStack {
                // Lista de listas creadas
                VStack(alignment: .leading) {
                    Text("Created Lists")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top)

                    // Mostrar las listas creadas
                    ForEach(lists, id: \.self) { list in
                        Text(list)
                            .font(.title2)
                            .padding(5)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .padding(.horizontal, 10)
                    }
                }

                Spacer() // Este spacer empuja los botones hacia abajo

                // Botones para crear una lista o unirse a una lista
                VStack(spacing: 20) {
                    NavigationLink(destination: CreateListView(lists: $lists)) {
                        Text("Create a List")
                            .font(.title2)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    NavigationLink(destination: Text("Join a List")) {
                        Text("Join a List")
                            .font(.title2)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 40) // Ajustar el margen para los botones
                .padding(.bottom, 20) // Separación adicional para los botones desde abajo
            }
            .padding()
            .navigationTitle("Inside Group View")
        }
    }
}

struct CreateListView: View {
    @Binding var lists: [String]  // Para actualizar la lista de grupos en InsideGroupView
    @State private var title: String = ""
    @State private var participants: [String] = ["Me", "Friend"]  // Lista inicial de participantes
    
    // Usamos el Environment para poder hacer un "dismiss" (volver atrás) cuando creamos la lista
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Create a New List")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)

                // Campo de título
                VStack(alignment: .leading, spacing: 5) {
                    Text("Title")
                        .font(.headline)
                    TextField("Enter list title", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                // Campo de participantes
                VStack(alignment: .leading, spacing: 5) {
                    Text("Participants")
                        .font(.headline)
                    
                    // Usar el índice como identificador único en el ForEach
                    ForEach(participants.indices, id: \.self) { index in
                        HStack {
                            TextField("Enter participant name", text: $participants[index])
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            // Botón de eliminar participante (cruz)
                            if participants.count > 2 {
                                Button(action: {
                                    participants.remove(at: index)
                                }) {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.red)
                                        .font(.title)
                                }
                            }
                        }
                    }
                    
                    // Botón para añadir más participantes
                    Button(action: {
                        participants.append("")  // Añade un campo vacío para un nuevo participante
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                            .font(.title)
                    }
                    .padding(.top, 10)
                }
                
                // Botón "Create List"
                Button(action: {
                    if !title.isEmpty {
                        // Agrega la lista creada al array de listas en InsideGroupView
                        lists.append(title)
                        
                        // Regresar a la vista anterior
                        dismiss()
                    }
                }) {
                    Text("Create List")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.top, 20)

                Spacer()
            }
            .padding()
            .navigationTitle("Create a List")
            .navigationBarBackButtonHidden(false) // Asegura que el botón de "back" esté visible
        }
    }
}

struct InsideGroupView_Previews: PreviewProvider {
    static var previews: some View {
        InsideGroupView()
    }
}


------------------------------------------------



THIS JOIN VIEW DOES NOT WORK YEt xd




struct JoinListView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var lists: [String]
    
    @State private var url: String = ""
    @State private var name: String = "John Doe"  // Nombre por defecto
    @State private var listName: String? = nil
    @State private var showWelcomeMessage = false

    var body: some View {
        NavigationView {
            VStack {
                TextField("URL", text: $url)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    if !url.isEmpty {
                        // Simular el proceso de obtener el nombre de la lista desde la URL
                        listName = "Sample List"  // Aquí deberías hacer una solicitud a la URL
                        showWelcomeMessage = true
                    }
                }) {
                    Text("Save Changes")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()

                if showWelcomeMessage, let listName = listName {
                    VStack {
                        Text("Welcome \(name) to \(listName)!")
                            .font(.title2)
                            .bold()
                            .padding(.top)

                        HStack {
                            Button(action: {
                                dismiss()  // Volver a InsideGroupView sin agregar la lista
                            }) {
                                Text("Decline")
                                    .font(.title2)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }

                            Button(action: {
                                if let listName = listName {
                                    lists.append(listName)  // Añadir la lista
                                }
                                dismiss()  // Volver a InsideGroupView
                            }) {
                                Text("Accept")
                                    .font(.title2)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.top, 20)
                    }
                    .padding()
                }
                
                // Volver a la vista anterior
                Button(action: {
                    dismiss()
                }) {
                    Text("Back")
                        .foregroundColor(.blue)
                }
                .padding(.top, 10)
            }
            .navigationTitle("Join List")
            .padding()
        }
    }
}

struct JoinListView_Previews: PreviewProvider {
    static var previews: some View {
        JoinListView(lists: .constant([]))
    }
}
