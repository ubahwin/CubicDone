import Foundation

struct Task: Identifiable, Equatable {
    var id = UUID()
    var draftID: UUID
    var title: String
    var status: TaskStatus = .todo
    var date: Date
}

enum TaskStatus {
    case todo, done
}
