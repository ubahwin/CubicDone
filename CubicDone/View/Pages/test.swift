import SwiftUI

struct TestView: View {
    @State private var currentPosition: CGPoint = .zero

    var body: some View {
         ScrollView(.horizontal) {
             LazyHStack(spacing: 0.0) {
                 ForEach(0..<1) { _ in
                     Rectangle()
                         .fill(.purple)
                         .containerRelativeFrame([.horizontal, .vertical])
                 }
             }
         }
    }
}

#Preview {
    TestView()
}
