import SwiftUI
import DequeModule

struct DayView: View {
    @Binding var day: Day

    @Binding var draggedTask: Task?
    @Binding var draggedOffset: CGSize
    @Binding var draggedPos: CGPoint

    var body: some View {
        Z {
            Rectangle()
                .fill(Color(hex: 0xeeeeee))
                .cornerRadius(10)

            V {
                H {
                    Text(day.date.formatted(Date.FormatStyle.custom))
                        .fontWeight(.semibold)
                        .padding()

                    Spacer()
                }

                ForEach($day.tasks) { task in
                    GeometryReader { geometry in
                        TaskInDayView(task: task)
                            .padding(.horizontal, 10)
                            .padding(.bottom, 8)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        let additionUpOffset: CGFloat = 50
                                        let taskPosition = geometry.frame(in: .global).origin

                                        withAnimation {
                                            draggedTask = task.wrappedValue
                                            draggedOffset = value.translation
                                            draggedPos = CGPoint(
                                                x: taskPosition.x + value.startLocation.x,
                                                y: taskPosition.y + value.startLocation.y - additionUpOffset
                                            )
                                        }
                                    }
                                    .onEnded { _ in
                                        withAnimation {
                                            draggedTask = nil
                                            draggedOffset = .zero
                                        }
                                    }
                            )
                            .opacity(draggedTask == task.wrappedValue ? 0.1 : 1)
                    }
                    .frame(height: 60)
                }

                Spacer()
            }
        }
    }
}

#Preview {
    DayView(
        day: .constant(.init(
        date: Date(),
        tasks: [.init(title: "title1", date: Date()), .init(title: "title2", date: Date())])
        ),
        draggedTask: .constant(.init(title: "title", date: Date())),
        draggedOffset: .constant(.zero),
        draggedPos: .constant(.zero)
    )
}
