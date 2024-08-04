import Foundation
import SwiftUI

struct Project: Identifiable {
    var id = UUID()
    var name: String
    var color: Color
    var status: DraftStatus = .notStarted

    var title: String {
        "#" + name
    }
}

enum DraftStatus: Hashable {
    case finished, notStarted, inProgress
}
