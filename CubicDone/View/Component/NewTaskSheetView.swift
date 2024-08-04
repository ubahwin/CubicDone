import SwiftUI

struct NewTaskSheetView: View {
    @Binding var newTaskTitle: String
    @Binding var selectedProject: String

    var body: some View {
        V {
            TextField("Task point", text: $newTaskTitle)
                .padding()

            Rectangle()
                .fill(Color(hex: 0xF5F5F5))
                .frame(height: 1)

            Spacer()

            H {
                Button {

                } label: {
                    Text(selectedProject)
                        .foregroundStyle(.black)
                        .padding(.vertical, 2)
                        .padding(.horizontal)
                        .background {
                            Rectangle()
                                .fill(Color(hex: 0xEDEDED))
                                .clipShape(.rect(cornerRadius: 4))
                        }
                        .padding(.horizontal)
                }

                Spacer()

                Button {

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
        selectedProject: .constant("No project")
    )
    .frame(height: 120)
}
