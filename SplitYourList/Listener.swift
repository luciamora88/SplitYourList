import SwiftUI
import FirebaseFirestore

class GroupViewModel: ObservableObject {
    @Published var groups: [Group] = []  // Observable property for groups
    private var db = Firestore.firestore()
    private var listener: ListenerRegistration?
    struct Group : Hashable
    {
        public var name :String;
        public var ID : String;
    }
    // Start listening for group changes in Firestore
    public func listenToGroups(Username: String) {
        listener = db.collection("User").document(Username).collection("Groups").addSnapshotListener { [weak self] querySnapshot, error in
            if let error = error {
                print("Error listening to Firestore updates: \(error.localizedDescription)")
                return
            }
            
            var newGroups: [Group] = [];
            querySnapshot?.documents.forEach { document in
                if let groupName = document.get("Name") as? String {
                    var group : Group = Group(name: "",ID: "");
                    group.name = groupName;
                    if let groupID = document.get("ID") as? String {
                        group.ID = groupID;
                        newGroups.append(group)
                    }
                }
            }
            DispatchQueue.main.async {
                self?.groups = newGroups
            }
        }
    }
    
    // Stop listening
    public func stopListening() {
        listener?.remove()
        listener = nil
    }
    
    // Add a new group
    func addGroup(_ groupName: Group) {
        groups.append(groupName)
            db.collection("User").addDocument(data: ["Name": groupName]) { error in
                if let error = error {
                    print("Error adding group to Firestore: \(error.localizedDescription)")
            }
        }
    }
    
    // Delete a group
    func deleteGroup(at offsets: IndexSet) {
        groups.remove(atOffsets: offsets)
        // Optionally, handle Firestore deletions here
    }
}
