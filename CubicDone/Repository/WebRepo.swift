import Foundation

protocol WebRepo {
    func getAllTodo() -> Task
}

class WepRepoStub: WebRepo {
    func getAllTodo() -> Task {
        Task(title: "stub", date: Date())
    }
}
