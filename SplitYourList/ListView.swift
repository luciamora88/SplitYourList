import SwiftUI
import FirebaseFirestore

struct ListView: View {
    // Input for the new group's title
    @State var groupName: String
    @State private var participants: [String] = ["Own Username", "Friends Username"]  // Initial participants
    @Binding var groups: [String]  // Binding to the `groups` array in GroupView
    @Environment(\.dismiss) var dismiss  // Dismiss environment to close the view
    
    @State var title: String = ""  // Group title input field
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create a New Group")
                .font(.largeTitle)
                .bold()
                .padding(.top)
                .padding(.leading)
            
            // Input field for the group's title
            VStack(alignment: .leading, spacing: 5) {
                Text("Title")
                    .font(.headline)
                TextField("Enter Group title", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

            // Input fields for participants
            VStack(alignment: .leading, spacing: 5) {
                Text("Participants")
                    .font(.headline)

                ForEach(participants.indices, id: \.self) { index in
                    HStack {
                        TextField("Enter participant name", text: $participants[index])
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        if participants.count > 2 {
                            Button(action: {
                                participants.remove(at: index) // Remove participant
                            }) {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundColor(.red)
                                    .font(.title)
                            }
                        }
                    }
                }

                Button(action: {
                    participants.append("")  // Add an empty participant field
                }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.blue)
                        .font(.title)
                }
                .padding(.top, 10)
            }
            
            // Create Group Button
            Button(action: {
                if !title.isEmpty {
                    // Append the new group to Firestore for each participant
                    Task {
                        let db = Firestore.firestore()
                        
                        // Loop through the participants and update the "Groups" field
                        for participant in participants {
                            let document = db.collection("User").document(participant) // Assuming "Users" collection
                            
                            document.updateData([
                                "Groups": FieldValue.arrayUnion([title])
                            ]) { error in
                                if let error = error {
                                    print("Error updating document: \(error.localizedDescription)")
                                } else {
                                    print("Document successfully updated for participant \(participant).")
                                }
                            }
                        }
                    }
                    
                    dismiss() // Close the ListView after creating the group
                }
            }) {
                Text("Create Group")
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
        .navigationBarBackButtonHidden(false)
    }
}

#Preview {
    ListView(groupName: "", groups: .constant([]))
}
