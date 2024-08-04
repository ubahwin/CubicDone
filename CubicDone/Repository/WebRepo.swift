import Foundation

protocol WebRepo {
    func getAllTodo() -> Task
}

class WepRepoStub: WebRepo {
    func getAllTodo() -> Task {
        ._stub
    }
}
