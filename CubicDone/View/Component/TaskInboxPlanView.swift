import SwiftUI

struct TaskInboxPlanView: View {
    @Binding var task: Task

    @Binding var isDragging: Bool
    @Binding var position: CGPoint
    @Binding var offset: CGSize

    private let gragHeightOffsetTreshold: CGFloat = 60

    var body: some View {
        Z {
            Rectangle()
                .fill(Color(hex: 0xeeeeee))

            V {
                H {
                    Text(task.title)
                        .padding(.horizontal, 10)
                        .padding(.top, 6)

                    Spacer()
                }

                Spacer()

                H {
                    Text(Date().formatted(Date.FormatStyle.custom))
                        .foregroundStyle(.gray)
                        .padding(.horizontal, 10)
                        .padding(.bottom, 6)
                        .font(.caption)

                    Spacer()
                }
            }
        }
        .frame(height: 60)
        .cornerRadius(8)
        .gesture(
            DragGesture()
                .onChanged { value in
                    if value.translation.height > gragHeightOffsetTreshold {
                        withAnimation {
                            offset = value.translation
                            isDragging = true
                        }
                    }
                }
                .onEnded { value in
                    withAnimation {
                        offset = .zero
                        isDragging = false
                    }
                }
        )
    }
}

#Preview {
    TaskInboxPlanView(
        task: .constant(.init(title: "Title")),
        isDragging: .constant(false),
        position: .constant(.zero),
        offset: .constant(.zero)
    )
}
