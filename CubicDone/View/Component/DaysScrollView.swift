import SwiftUI

struct DaysScrollView<Content: View>: View {
    @State private var moveOffset: CGFloat = 0
    @State private var mainOffset: CGFloat = 0
    @State private var contentWidth: CGFloat = 0

    @Binding var goToMiddle: Bool

    private let content: Content
    private let load: (Direction) -> Void
    private var queue = DispatchQueue.global(qos: .userInteractive)

    init(
        goToMiddle: Binding<Bool>,
        load: @escaping (Direction) -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._goToMiddle = goToMiddle
        self.load = load
        self.content = content()
    }

    var body: some View {
        GeometryReader { geometry in
            let containerWidth = geometry.size.width
            let maxOffset = max(0, contentWidth - containerWidth / 2)
            let minOffset = min(0, -contentWidth + containerWidth / 2)

            content
            // give width all ChildView
                .background(GeometryReader { geometry in
                    Color.clear
                        .onAppear {
                            contentWidth = geometry.size.width / 2
                        }
                        .onChange(of: geometry.size) {
                            contentWidth = geometry.size.width / 2
                        }
                })
                .offset(x: moveOffset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            moveOffset = value.translation.width + mainOffset
                        }
                        .onEnded { value in
                            let predictedEnd = value.predictedEndTranslation.width + mainOffset
                            let clampedOffset = min(max(predictedEnd, minOffset), maxOffset)

                            withAnimation(.easeOut(duration: 0.8)) {
                                moveOffset = clampedOffset
                            }

                            if moveOffset < -contentWidth + containerWidth {
                                queue.async {
                                    load(.start)
                                }
                            }

                            if moveOffset > contentWidth - containerWidth {
                                queue.async {
                                    load(.end)
                                }
                            }

                            mainOffset = moveOffset
                        }
                )
                .frame(width: containerWidth)
        }
        .onChange(of: goToMiddle) {
            withAnimation(.easeOut(duration: 0.6)) {
                moveOffset = 0
            }

            mainOffset = 0
            goToMiddle = false
        }
    }
}

#Preview {
    DaysScrollView(
        goToMiddle: .constant(false),
        load: { _ in
            sleep(2)
            print("sleep")
        }
    ) {
        H(sp: 10) {
            ForEach(0..<15) { _ in
                Rectangle()
                    .fill(.red)
                    .frame(width: 260)
            }
        }
    }
}
