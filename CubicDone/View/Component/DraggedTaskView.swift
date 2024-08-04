import SwiftUI

struct DraggedTaskView: View {
    var draggedTask: Task

    var body: some View {
        H {
            Text(draggedTask.title)

            Spacer()
        }
        .zIndex(1)
        .frame(width: 140)
        .padding()
        .background(.white)
        .cornerRadius(8)
        .padding(.horizontal)
        .lineLimit(1)
        .shadow(color: .gray, radius: 10)
    }
}

#Preview {
    DraggedTaskView(draggedTask: ._stub)
}
