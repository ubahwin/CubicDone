import SwiftUI
import DequeModule

struct DayView: View {
    let dayIndex: Int
    @Binding var days: Deque<Day>

    @Binding var isDragging: Bool
    @Binding var position: CGPoint
    @Binding var offset: CGSize

    var body: some View {
        Z {
            Rectangle()
                .fill(Color(hex: 0xeeeeee))
                .cornerRadius(10)

            V {
                H {
                    Text(days[dayIndex].date.formatted(Date.FormatStyle.custom))
                        .fontWeight(.semibold)
                        .padding()

                    Spacer()
                }

                ForEach($days[dayIndex].tasks) { task in
                    TaskInDayView(
                        task: task,
                        isDragging: $isDragging,
                        position: $position, 
                        offset: $offset
                    )
                        .padding(.horizontal, 10)
                        .padding(.bottom, 8)
                }

                Spacer()
            }
        }
    }
}

#Preview {
    DayView(
        dayIndex: 0,
        days: .constant(
            [Day(date: Date(), tasks: [.init(title: "title"),.init(title: "title2")])]
        ),
        isDragging: .constant(false), 
        position: .constant(.zero),
        offset: .constant(.zero)
    )
}
