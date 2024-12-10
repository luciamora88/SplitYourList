////
////  ItemView.swift
////  SplitYourList
////
////  Created by Rathang Pandit on 12/10/24.
////
//
//import SwiftUI
//struct ItemView: View {
//    @State private var userInput = ""
//    @State var templateGroup: [String] = ["Template: Create List Below"]
//    @State var showingInputField = false
//    
//    var body: some View {
//        NavigationView {
//            ZStack {
//                VStack {
//                    List {
//                        ForEach(templateGroup, id: \.self) { templategroup in
//                            Text(templategroup)
//                        }
//                        ForEach(items, id: \.self) { item in
//                            Text(item)
//                        }
//                        .onDelete(perform: delete)
//                        .onMove(perform: move)
//                    }
//                    
//                    // The NavigationLink that will lead to ListView for creating new groups
//                    NavigationLink(destination: ShoppingListView()){
//                        Text("Add List")
//                    }
//                    .padding()
//                }
//                
//                if showingInputField {
//                    VStack {
//                        Spacer()
//                        VStack {
//                            Text("Enter List Name")
//                                .font(.headline)
//                                .padding()
//                            
////                            TextField("Group Name", text: $userInput)
////                                .textFieldStyle(RoundedBorderTextFieldStyle())
////                                .padding()
//                            
//                            HStack {
//                                Button("Cancel") {
//                                    cancel()
//                                }
//                                .padding()
//                                
//                                Button("Add") {
//                                    add()
//                                }
//                                .padding()
//                            }
//                        }
//                        .frame(maxWidth: .infinity, maxHeight: 300)
//                        .background(Color.white)
//                        .cornerRadius(10)
//                        .shadow(radius: 10)
//                        .padding(40)
//                        .transition(.scale)
//                        Spacer()
//                    }
//                    .background(Color.black.opacity(0.4))
//                    .edgesIgnoringSafeArea(.all)
//                    .zIndex(1)
//                }
//            }
//            .navigationTitle("Lists")
//            .navigationBarItems(leading: EditButton())
//        }
//    }
//    
//    func delete(indexSet: IndexSet) {
//        items.remove(atOffsets: indexSet)
//    }
//    
//    func move(indices: IndexSet, newOffset: Int) {
//        items.move(fromOffsets: indices, toOffset: newOffset)
//    }
//    
//    func add() {
//        if !userInput.isEmpty {
//            items.append(userInput)
//            userInput = ""
//            showingInputField = false
//        }
//    }
//    
//    func cancel() {
//        showingInputField = false
//        userInput = ""
//    }
//}
//
//#Preview {
//    ItemView()
//}
//
