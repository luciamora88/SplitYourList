import SwiftUI

struct GroupView: View {
    var Username : String
    @State private var userInput = ""
    @State private var showingInputField = false
    @StateObject private var groupViewModel = GroupViewModel()
    @Environment(\.editMode) var editMode
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    // Groups List
                    List {
                        ForEach(groupViewModel.groups, id: \.self) { group in
                            NavigationLink(destination: ItemView(GroupID: group.ID)) {
                                Text(group.name)
                            }
                        }
                        .onDelete { indexSet in
                            groupViewModel.deleteGroup(at: indexSet)
                        }
                    }
                    .environment(\.editMode, editMode)
                    
                    // Add Group Button
                    NavigationLink(destination: ListView())
                    {
                        Text("Add Group")
                    }
                    .padding()
                }
            }
            .navigationTitle("Groups")
            .toolbar {
                EditButton()
            }
        }
        .onAppear
        {
            groupViewModel.listenToGroups(Username: Username)
        }
        .onDisappear
        {
            groupViewModel.stopListening()
        }
    }

}

#Preview {
    GroupView(Username: "")
}
