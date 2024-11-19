import SwiftUI

struct ListView: View {
    @State private var title: String = ""
    @State var groupName: String  // Use the passed groupName
    @State private var participants: [String] = ["Me", "Friend"]  // Initial participants
   
    @Environment(\.dismiss) var dismiss  // Environment dismiss to pop the view
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Create a New List for \(groupName)") // Display the group name
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)

                // Title input field
                VStack(alignment: .leading, spacing: 5) {
                    Text("Title")
                        .font(.headline)
                    TextField("Enter list title", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                // Participants input fields
                VStack(alignment: .leading, spacing: 5) {
                    Text("Participants")
                        .font(.headline)
                   
                    ForEach(participants.indices, id: \.self) { index in
                        HStack {
                            TextField("Enter participant name", text: $participants[index])
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                           
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
                   
                    Button(action: {
                        participants.append("")  // Add new empty participant field
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                            .font(.title)
                    }
                    .padding(.top, 10)
                }
               
                // Create list button
                Button(action: {
                    if !title.isEmpty {
                        // Handle creating the list
                        dismiss()  // Dismiss the view after creation
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
            .navigationBarBackButtonHidden(false)
        }
    }
}

#Preview {
    ListView(groupName: "Sample Group")
}
