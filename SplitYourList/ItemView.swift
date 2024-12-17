//
//  ItemView.swift
//  SplitYourList
//
//  Created by Rathang Pandit on 12/10/24.
//

import SwiftUI
struct ItemView: View {
    var GroupID: String
    @State private var userInput = ""
    @State private var username = ""
    @State var templateGroup: [String] = ["Template: Create List Below"]
    @State var items: [String] = []
    @StateObject private var listViewModel = ListViewModel()
    @State var showingInputField = false
    @State var showingInputField2 = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List {
                        ForEach(listViewModel.lists, id: \.self) { templategroup in
                            NavigationLink(destination: ShoppingListView())
                            {
                                Text(templategroup.name)
                            }
                        }
                        
//                        ForEach(items, id: \.self) { item in
//                            NavigationLink(destination: ShoppingListView())
//                            {
//                                Text(item)
//                            }
//                        }
                        .onDelete(perform: delete)
                        .onMove(perform: move)
                    }
                    
                    // The NavigationLink that will lead to ListView for creating new groups
                    Button("Add List")
                    {
                        showingInputField.toggle()
                    }
                    Button("Invite")
                    {
                        showingInputField2.toggle()
                    }
                    
                    
                }
                
                if showingInputField {
                    VStack {
                        Spacer()
                        VStack {
                            Text("Enter List Name")
                                .font(.headline)
                                .padding()
                            
                            TextField("List Name", text: $userInput)
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
            .navigationTitle("Lists")
            .navigationBarItems(leading: EditButton())
        if showingInputField2 {
            VStack {
                Spacer()
                VStack {
                    Text("Invite User")
                        .font(.headline)
                        .padding()
                    
                    TextField("", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    HStack {
                        Button("Cancel") {
                            cancel2()
                        }
                        .padding()
                        
                        Button("Invite")
                        {
                            
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
    //.navigationBarItems(leading: EditButton())
}
    
    func delete(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func move(indices: IndexSet, newOffset: Int) {
        items.move(fromOffsets: indices, toOffset: newOffset)
    }
    
    func add() {
        if !userInput.isEmpty {
            items.append(userInput)
            userInput = ""
            showingInputField = false
        }
    }
    
    func invite()
    {
        
    }
    
    func cancel2() {
        showingInputField = false
        username = ""
    }
    
    func cancel() {
        showingInputField = false
        userInput = ""
    }
}

#Preview {
    ItemView(GroupID : "")
}

