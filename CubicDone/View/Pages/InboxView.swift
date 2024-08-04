import SwiftUI
import Collections

struct InboxView: View {
    @State private var inboxTasks: [Task] = [
        .init(title: "title1", date: Date()),
        .init(title: "title2", date: Date()),
        .init(title: "title3", date: Date()),
        .init(title: "title4", date: Date()),
        .init(title: "title5", date: Date())
    ]

    @State private var newTask = false
    @State private var newTaskTitle = ""

    @State private var selectedProject = "No project"

    var body: some View {
        NavigationStack {
            Z {
                V {
                    if inboxTasks.isEmpty {
                        V {
                            Text("Write everything on your mind.")
                            Text("Clear it, to achieve better performance.")
                        }
                        .foregroundStyle(.gray)
                        .font(.callout)
                    } else {
                        ScrollView(showsIndicators: false) {
                            V {
                                ForEach(inboxTasks) { task in
                                    Z {
                                        V {
                                            Rectangle()
                                                .fill(.clear)
                                                .frame(height: 43)
                                            Rectangle()
                                                .fill(Color(hex: 0xF5F5F5))
                                                .frame(height: 1)
                                        }

                                        H {
                                            Text(task.title)
                                                .foregroundStyle(Color(hex: 0x0F0F0F))
                                                .padding(.horizontal)
                                            Text(task.date, format: .dateTime)
                                                .foregroundStyle(Color(hex: 0xC2C2C2))
                                                .font(.callout)

                                            Spacer()

                                            Text("#procollab")
                                                .foregroundStyle(Color(hex: 0xF70AFB))
                                                .padding(.vertical, 2)
                                                .padding(.horizontal, 6)
                                                .background {
                                                    Rectangle()
                                                        .fill(Color(hex: 0xFED2FE))
                                                        .clipShape(.capsule)
                                                }
                                                .padding(.horizontal)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                V {
                    Spacer()
                    H {
                        Spacer()

                        Button {
                            newTask = true
                        } label: {
                            Z {
                                Rectangle()
                                    .fill(Color(hex: 0x0F0F0F))
                                    .frame(width: 44, height: 44)
                                    .cornerRadius(8)
                                    .padding(20)

                                Image(systemName: "plus")
                                    .foregroundStyle(.white)
                                    .font(.title)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Inbox")
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $newTask) {
            NewTaskSheetView(
                newTaskTitle: $newTaskTitle,
                selectedProject: $selectedProject
            )
            .presentationDetents([.medium])
            .presentationCornerRadius(12)
        }
    }
}

#Preview {
    InboxView()
}
