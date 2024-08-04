import SwiftUI

struct ProjectsView: View {
    @State private var projects: [Project] = [
        ._stub,
        ._stub,
        ._stub,
        ._stub
    ]

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                ForEach(projects) { project in
                    Text(project.title)
                }
            }
            .navigationTitle("Projects")
        }
    }
}

#Preview {
    ProjectsView()
}
