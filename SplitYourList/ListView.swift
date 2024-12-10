import SwiftUI

struct ListView: View {
    @State private var title: String = "" // Input for the new group's title
    @State var groupName: String  // Placeholder to handle the group's name
    @State private var participants: [String] = ["Me", "Friend"]  // Initial participants
    @Binding var groups: [String] // Binding to the `groups` array in GroupView
    @Environment(\.dismiss) var dismiss  // Dismiss environment to close the view
    
    var body: some View {
        NavigationView {
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
                        // Append the new group to the groups array
                        groups.append(title)
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
}

#Preview {
    ListView(groupName: "", groups: .constant([]))
}
