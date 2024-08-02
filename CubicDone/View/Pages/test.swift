import SwiftUI

struct Test1View: View {
    @State private var scrollOffset: CGFloat = 0

    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<50) { i in
                    Text("Элемент \(i)")
                        .frame(height: 50)
                        .background(Color.blue.opacity(0.3))
                }
            }
            .background(GeometryReader { proxy in
                Color.clear.preference(key: ScrollOffsetPreferenceKey.self, value: -proxy.frame(in: .named("scroll")).origin.y)
            })
        }
        .coordinateSpace(name: "scroll")
        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
            scrollOffset = value
        }
        .overlay(Text("Смещение: \(scrollOffset)"))
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

struct Test2View: View {
    @Namespace var topID
    @Namespace var bottomID

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                H {
                    Button("Scroll to Bottom") {
                        proxy.scrollTo(bottomID, anchor: .bottomLeading)
                    }
                    .id(topID)

                    H {
                        ForEach(0..<100) { i in
                            color(fraction: Double(i) / 100)
                                .frame(width: 32)
                        }
                    }

                    Button("Top") {
                        withAnimation {
                            proxy.scrollTo(topID)
                        }
                    }
                    .id(bottomID)
                }
            }
        }
    }

    func color(fraction: Double) -> Color {
        Color(red: fraction, green: 1 - fraction, blue: 0.5)
    }
}

#Preview(body: {
    Test2View()
})
