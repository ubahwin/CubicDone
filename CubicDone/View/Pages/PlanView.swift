import SwiftUI
import Collections

struct PlanView: View {
    @State private var days: Deque<Day> = {
        var daysArray = Deque<Day>()
        let currentDate = Date()

        for i in -11...11 {
            if let date = Calendar.current.date(byAdding: .day, value: i, to: currentDate) {
                daysArray.append(Day(date: date, tasks: []))
            }
        }

        daysArray[daysArray.count / 2].tasks.append(.init(title: "title"))

        return daysArray
    }()

    @State private var inboxTasks: [Task] = [
        Task(title: "title1"),
        Task(title: "title2"),
        Task(title: "title3"),
        Task(title: "title4"),
        Task(title: "title5")
    ]

    @State private var goToMiddle = false

    @State private var curIsDragging = false
    @State private var curDragOffset: CGSize = .zero
    @State private var curDragPos: CGPoint = .zero

    var body: some View {
        Z {
            if curIsDragging {
                Text("titlee")
                    .padding(.horizontal)
                    .position(curDragPos)
                    .offset(curDragOffset)
                    .zIndex(1)
            }

            V {
                H {
                    Label {
                        Text("Inbox")
                    } icon: {
                        Image(systemName: "tray")
                    }
                    .padding(.horizontal)

                    Spacer()
                }

                ScrollView(.horizontal, showsIndicators: false) {
                    H(sp: 10) {
                        ForEach($inboxTasks) { task in
                            TaskInboxPlanView(
                                task: task,
                                isDragging: $curIsDragging,
                                position: $curDragPos,
                                offset: $curDragOffset
                            )
                        }
                    }
                }
                .padding()

                H(sp: nil) {
                    Button {
                        goToMiddle = true
                    } label: {
                        Text("Today")
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background {
                                Rectangle()
                                    .fill(Color(hex: 0xeeeeee))
                                    .cornerRadius(4)
                            }
                            .tint(.black)
                    }
                    .padding(.horizontal)

                    Spacer()
                }

                DaysScrollView(
                    goToMiddle: $goToMiddle,
                    load: loadDays
                ) {
                    LazyHStack {
                        let daysIndices = days.indices

                        ForEach(daysIndices, id: \.self) { dayIndex in
                            DayView(
                                dayIndex: dayIndex,
                                days: $days,
                                isDragging: $curIsDragging,
                                position: $curDragPos,
                                offset: $curDragOffset
                            )
                                .frame(width: 260)
                        }
                    }
                }
                .padding(.vertical)
            }
        }
    }

    //
    // TODO: optimization, 2 direction –> 1 direction from pagination
    //
    // Надо оптимизировать, потому что сейчас тратится в 2 раза
    // больше памяти из-за того, что в деку дни добавляются как в
    // начало так и в конец. Благодаря этому мой scroll view не
    // сдвигается и не дёргается (почти), надо настроить там offset`ы
    //
    private func loadDays(to direction: Direction) {
        let calendar = Calendar.current

        if let mountElem = direction == .start ? days.first : days.last {
            let date = mountElem.date

            for i in 1...10 {
                if let newDate = calendar.date(
                    byAdding: .day,
                    value: direction == .start ? -i : i,
                    to: date
                ) {
                    let newDay = Day(date: newDate, tasks: [])

                    if direction == .start {
                        days.prepend(newDay)
                    } else {
                        days.append(newDay)
                    }
                }
            }
        }

        if let mountElem = direction == .end ? days.first : days.last {
            let date = mountElem.date

            for i in 1...10 {
                if let newDate = calendar.date(
                    byAdding: .day,
                    value: direction == .end ? -i : i,
                    to: date
                ) {
                    let newDay = Day(date: newDate, tasks: [])

                    if direction == .end {
                        days.prepend(newDay)
                    } else {
                        days.append(newDay)
                    }
                }
            }
        }
    }
}

#Preview {
    PlanView()
}
