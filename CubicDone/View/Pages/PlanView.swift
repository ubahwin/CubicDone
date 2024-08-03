import SwiftUI
import Collections
import BetterScrollViewSwiftUI

struct PlanView: View {
    @State private var days: Deque<Day>

    private var todayIndex: Int

    @State private var inboxTasks: [Task] = [
        Task(title: "Покормить собаку"),
        Task(title: "Сделать там чето работу"),
        Task(title: "title3"),
        Task(title: "title4"),
        Task(title: "title5")
    ]

    @State private var goToMiddle = false

    @State private var draggedTask: Task?
    @State private var draggedOffset: CGSize = .zero
    @State private var draggedPos: CGPoint = .zero

    init() {
        let initialDays = initialDays
        let todayIndex = initialDays.count / 2

        self.days = initialDays
        self.todayIndex = todayIndex
    }

    private var initialDays: Deque<Day> = {
        var daysArray = Deque<Day>()
        let currentDate = Date()

        for i in -9...9 {
            if let date = Calendar.current.date(byAdding: .day, value: i, to: currentDate) {
                daysArray.append(Day(date: date, tasks: []))
            }
        }

        // TODO: delete
        daysArray[daysArray.count / 2].tasks.append(.init(title: "Ноготочки"))
        daysArray[daysArray.count / 2].tasks.append(.init(title: "Погладить кошку"))
        daysArray[daysArray.count / 2].tasks.append(.init(title: "title3"))
        daysArray[daysArray.count / 2].tasks.append(.init(title: "title4"))

        return daysArray
    }()

    var body: some View {
        Z {
            if let draggedTask = draggedTask {
                DraggedTaskView(draggedTask: draggedTask)
                    .offset(draggedOffset)
                    .position(draggedPos)
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
                    H(sp: 8) {
                        ForEach($inboxTasks) { task in
                            GeometryReader { geometry in
                                TaskInboxPlanView(task: task)
                                    .gesture(
                                        DragGesture()
                                            .onChanged { value in
                                                if value.translation.height < 20 {
                                                    return
                                                }

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
                            }
                            .frame(width: 180, height: 60)
                        }
                    }
                }
                .padding()

                H(sp: nil) {
                    Button {
                        withAnimation {
                            goToMiddle.toggle()
                        }
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

                    Button("add") {
                        loadDays(to: .end)
                    }
                }

                DaysScrollView(
                    goToMiddle: $goToMiddle,
                    draggedOffset: $draggedOffset,
                    load: loadDays
                ) {
                    LazyHStack {
                        ForEach($days) { day in
                            DayView(
                                day: day,
                                draggedTask: $draggedTask,
                                draggedOffset: $draggedOffset,
                                draggedPos: $draggedPos
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

        print("load \(direction)")
    }
}

#Preview {
    PlanView()
}



// -----------------------------
// With BetterScrollView realize
// -----------------------------

// Не работает пагинация слева справа, точнее невозможно реализовать,
// так как сначала скролл вью перемещается на начало деки (массив), после
// onAppear() переход на середину, однако .onAppear() срабатывает
// и на первые ячейки, а они нужны для левой (.start) пагинации.

// Так же при добавлении новых эл-ов в деку, скроллвью смещается, дергается.
// Изменить offset вручную нельзя, приходится телепортироваться по .id()



//                BetterScrollView(
//                    axes: .horizontal,
//                    showsIndicators: false,
//                    contentOffset: $bsOffset,
//                    scrollDirection: $bsScrollDirection
//                ) { proxy in
//                    LazyHStack {
//                        let daysIndices = days.indices
//
//                        ForEach(daysIndices, id: \.self) { dayIndex in
//                            let curID = days[dayIndex].id
//
//                            DayView(
//                                dayIndex: dayIndex,
//                                days: $days
//                            )
//                            .id(curID)
//                            .frame(width: 234)
//                            .onAppear {
//                                if dayIndex == 5 {
//                                    loadDays(to: .start)
//                                    proxy.scrollTo(curID, anchor: .leading)
//                                    print("load start \(dayIndex)")
//                                } else if dayIndex == daysIndices.upperBound - 1 {
//                                    loadDays(to: .end)
//                                    proxy.scrollTo(curID, anchor: .trailing)
//                                    print("load end \(dayIndex)")
//                                }
//                            }
//                        }
//                    }
//                    .onAppear {
//                        proxy.scrollTo(todayID, anchor: .center)
//                    }
//                    .onChange(of: goToMiddle) {
//                        proxy.scrollTo(todayID, anchor: .center)
//                    }
//                }
//                .padding(.vertical)
