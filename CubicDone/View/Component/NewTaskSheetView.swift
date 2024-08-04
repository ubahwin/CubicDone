import SwiftUI

struct NewTaskSheetView: View {
    @Environment(\.dismiss) var dismiss

    @Binding var newTaskTitle: String
    @Binding var openProjects: Bool
    @State private var selectedProject: Project?

    @State private var projects: [Project] = [
        .init(name: "project1", color: .blue),
        .init(name: "project2", color: .red),
        .init(name: "project3", color: .green)
    ]

    var body: some View {
        V {
            if openProjects {
                ScrollView {
                    ForEach(projects) { project in
                        Button {
                            selectedProject = project

                            withAnimation {
                                openProjects = false
                            }
                        } label: {
                            H {
                                Circle()
                                    .fill(project.color)
                                    .frame(height: 16)
                                    .padding(.horizontal)

                                Text(project.name)
                                    .foregroundStyle(.black)

                                Spacer()

                                if selectedProject?.id == project.id {
                                    Image(systemName: "checkmark")
                                        .padding(.horizontal)
                                }
                            }
                        }
                        .frame(height: 28)
                    }
                }
                .padding(.top)
                .frame(height: 120)
            }

            TextField("Task point", text: $newTaskTitle)
                .padding()

            Rectangle()
                .fill(Color(hex: 0xF5F5F5))
                .frame(height: 1)

            Spacer()

            H {
                Button {
                    withAnimation {
                        openProjects.toggle()
                    }
                } label: {
                    Text(selectedProject?.title ?? "No Project")
                        .foregroundStyle(.black)
                        .padding(.vertical, 2)
                        .padding(.horizontal)
                        .background {
                            Rectangle()
                                .fill(selectedProject == nil ? Color(hex: 0xEDEDED) : selectedProject!.color)
                                .clipShape(.rect(cornerRadius: 4))
                        }
                        .padding(.horizontal)
                }

                Spacer()

                Button {
                    dismiss()
                    openProjects = false
                } label: {
                    Z {
                        Rectangle()
                            .fill(Color(hex: 0x0F0F0F))
                            .frame(width: 36, height: 36)
                            .clipShape(.rect(cornerRadius: 4))
                            .padding()

                        Image(systemName: "checkmark")
                            .foregroundStyle(.white)
                    }
                }
            }
        }
    }
}

#Preview {
    NewTaskSheetView(
        newTaskTitle: .constant("title"),
        openProjects: .constant(true)
    )
    .frame(height: 120)
}
