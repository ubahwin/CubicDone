import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PlanView()
                .tabItem {
                    Text("Plan")
                    Image(systemName: "calendar")
                }

            InboxView()
                .tabItem {
                    Text("Inbox")
                    Image(systemName: "tray")
                }

            ProjectsView()
                .tabItem {
                    Text("Projects")
                    Image(systemName: "folder")
                }
        }
        .tint(.black)
    }
}

#Preview {
    ContentView()
}
