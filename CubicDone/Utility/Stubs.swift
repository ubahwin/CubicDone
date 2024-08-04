import Foundation

extension Task {
    static var _stub: Self {
        .init(draftID: UUID(), title: "title", status: .todo, date: .now)
    }
}

extension Day {
    static var _stub: Self {
        .init(date: .now, tasks: [._stub, ._stub])
    }
}

extension Project {
    static var _stub: Self {
        .init(name: "project", color: .blue)
    }
}
