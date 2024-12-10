import SwiftUI
import FirebaseFirestore

class FirebaseViewModel: ObservableObject
{
    @Published var items: [String] = [] // Example data

    private var db = Firestore.firestore()

    init() {
        fetchItems()
    }

    func fetchItems() {
            let ref = db.collection("Groups").addDocument(data: [
                "Test": "IsWorking"
            ])
            print("Doc added! \(ref.documentID)")
    }
}
