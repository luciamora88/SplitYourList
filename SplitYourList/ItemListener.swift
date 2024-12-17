//
//  ItemListener.swift
//  SplitYourList
//
//  Created by Rathang Pandit on 12/16/24.
//

import SwiftUI
import FirebaseFirestore

class ListViewModel: ObservableObject {
    @Published var lists: [ListItem] = []  // Observable property for groups
    private var db = Firestore.firestore()
    private var listener: ListenerRegistration?
    struct ListItem : Hashable
    {
        public var name :String;
        public var ID : String;
    }
    // Start listening for group changes in Firestore
    public func listenToLists(GroupID: String) {
        listener = db.collection("Groups").document(GroupID).collection("Lists").addSnapshotListener { [weak self] querySnapshot, error in
            if let error = error {
                print("Error listening to Firestore updates: \(error.localizedDescription)")
                return
            }
            
            var newLists: [ListItem] = []
            querySnapshot?.documents.forEach { document in
                if let listName = document.get("Name") as? String {
                    var listItem : ListItem = ListItem(name: "",ID: "");
                    listItem.name = listName;
                    if let listID = document.get("ID") as? String {
                        listItem.ID = listID;
                        newLists.append(listItem)
                    }
                }
            }
            DispatchQueue.main.async {
                self?.lists = newLists
            }
        }
    }
    
    // Stop listening
    public func stopListening() {
        listener?.remove()
        listener = nil
    }
    
    // Add a new group
    func addLists(_ listName: ListItem) {
        lists.append(listName)
            db.collection("Lists").addDocument(data: ["Name": listName]) { error in
                if let error = error {
                    print("Error adding group to Firestore: \(error.localizedDescription)")
            }
        }
    }
    
    // Delete a group
    func deleteLists(at offsets: IndexSet) {
        lists.remove(atOffsets: offsets)
        // Optionally, handle Firestore deletions here
    }
}
