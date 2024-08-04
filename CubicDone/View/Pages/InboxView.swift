import SwiftUI
import Collections

struct InboxView: View {
    @State private var inboxTasks: [Task] = [
        .init(draftID: UUID(), title: "oyausf asdfoagq qwe cshja", date: .now),
        ._stub,
        ._stub,
        ._stub,
        ._stub,
        ._stub,
        ._stub
    ]

    @State private var newTask = false
    @State private var openProjects = false
    @State private var newTaskTitle = ""

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
                                                .frame(height: 60)
                                            Rectangle()
                                                .fill(Color(hex: 0xF5F5F5))
                                                .frame(height: 1)
                                        }

                                        H {
                                            V(.leading) {
                                                Text(task.title)
                                                    .foregroundStyle(Color(hex: 0x0F0F0F))
                                                    .padding(.vertical, 6)
                                                    .lineLimit(1)
                                                Text(task.date, format: .dateTime)
                                                    .foregroundStyle(Color(hex: 0xC2C2C2))
                                                    .font(.footnote)
                                            }
                                            .padding(.horizontal)

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
        }
        .sheet(isPresented: $newTask) {
            NewTaskSheetView(
                newTaskTitle: $newTaskTitle,
                openProjects: $openProjects
            )
            .presentationDetents([.height(openProjects ? 320 : 200)])
            .presentationCornerRadius(12)
            .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    InboxView()
}
