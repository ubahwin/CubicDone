import Foundation

struct Day: Identifiable {
    var id = UUID()
    var date: Date
    var tasks: [Task]
}
