//
//  Listener.swift
//  SplitYourList
//
//  Created by Zachary James Howe on 12/16/24.
//

import SwiftUI
import FirebaseFirestore

class ListViewModel: ObservableObject
{
    @Published var lists: [String] = []
    private var db = Firestore.firestore()
    private var listener: ListenerRegistration?
    
    init()
    {
//        Listen()
    }
    
    deinit
    {
        StopListening()
    }
    
    
//    func Listen()
//    {
//        listener = db.collection("default")
//            .addSnapshotListener{ (querySnapshot, error) in
//                if let error = error{
//                    print("not working :(")
//                    return
//                }
//                
//                self.lists = querySnapshot?.documents.compactMap { document in
//                    try? document.get("GroupID_0")} ?? []
//            }
//    }
    
    func StopListening()
    {
        
    }
}


