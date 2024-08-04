import SwiftUI

struct TaskInDayView: View {
    @Binding var task: Task

    @State var isCompleted = false

    var body: some View {
        H {
            Button {
                isCompleted.toggle()
            } label: {
                Z {
                    if isCompleted {
                        Image(systemName: "checkmark.circle")
                    } else {
                        Image(systemName: "circle.dashed")
                    }
                }
                .tint(.gray)
                .font(.title)
            }

            Text(task.title)
                .padding(.horizontal)

            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(.white)
        .cornerRadius(8)
    }
}

#Preview {
    Z {
        Rectangle()
            .fill(.gray)
            .ignoresSafeArea()
        TaskInDayView(
            task: .constant(.init(title: "title", date: Date()))
        )
        .padding()
    }
}
