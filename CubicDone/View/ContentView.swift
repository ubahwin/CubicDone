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

            Test2View()
                .tabItem {
                    Text("Test")
                    Image(systemName: "testtube.2")
                }
        }
        .tint(.black)
    }
}

#Preview {
    ContentView()
}
