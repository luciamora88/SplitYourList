import SwiftUI
struct GroupView: View {
    @State private var userInput = ""
    @State var templateGroup: [String] = ["Template: Create Group Below"]
    @State var groups: [String] = []
    @State var showingInputField = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    List {
                        ForEach(groups, id: \.self) { group in
                            NavigationLink(destination: ItemView())
                            {
                                Text(group)
                            }
                        }
                        .onDelete(perform: delete)
                        .onMove(perform: move)
                    }

                    NavigationLink(destination: ListView(groupName: "", groups: $groups)) {
                        Text("Add Group")
                    }
                    .padding()
                }
                
                if showingInputField {
                    VStack {
                        Spacer()
                        VStack {
                            Text("Enter Group Name")
                                .font(.headline)
                                .padding()
                            
                            TextField("Group Name", text: $userInput)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                            
                            HStack {
                                Button("Cancel") {
                                    cancel()
                                }
                                .padding()
                                
                                Button("Add") {
                                    add()
                                }
                                .padding()
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding(40)
                        .transition(.scale)
                        Spacer()
                    }
                    .background(Color.black.opacity(0.4))
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(1)
                }
            }
            .navigationTitle("Groups")
            .navigationBarItems(leading: EditButton())
        }
        
    }
    
    func delete(indexSet: IndexSet) {
        groups.remove(atOffsets: indexSet)
    }
    
    func move(indices: IndexSet, newOffset: Int) {
        groups.move(fromOffsets: indices, toOffset: newOffset)
    }
    
    func add() {
        if !userInput.isEmpty {
            groups.append(userInput)
            userInput = ""
            showingInputField = false
        }
    }
    
    func cancel() {
        showingInputField = false
        userInput = ""
    }
}

#Preview {
    GroupView()
}
