import SwiftUI

struct TaskInDayView: View {
    @Binding var task: Task

    @Binding var isDragging: Bool
    @Binding var position: CGPoint
    @Binding var offset: CGSize

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
        .gesture(
            DragGesture()
                .onChanged { value in
                    withAnimation {
                        isDragging = true
                        position = value.startLocation
                        offset = value.translation
                    }
                }
                .onEnded { value in
                    withAnimation {
                        isDragging = false
                        position = .zero
                    }
                }
        )
    }
}

#Preview {
    Z {
        Rectangle()
            .fill(.gray)
            .ignoresSafeArea()
        TaskInDayView(
            task: .constant(.init(title: "title")),
            isDragging: .constant(false), 
            position: .constant(.zero),
            offset: .constant(.zero)
        )
            .padding()
    }
}
