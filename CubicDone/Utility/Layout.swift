import SwiftUI

// Explanation: spacing = nil
// swiftlint:disable type_name
struct V<Content: View>: View {
    private let align: HorizontalAlignment
    let content: Content
    let spacing: CGFloat?

    init(
        _ align: HorizontalAlignment = .center,
        sp: CGFloat? = 0,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.align = align
        self.content = content()
        self.spacing = sp
    }

    var body: some View {
        VStack(alignment: align, spacing: spacing) { content }
    }
}

struct H<Content: View>: View {
    private let align: VerticalAlignment
    let content: Content
    let spacing: CGFloat?

    init(
        _ align: VerticalAlignment = .center,
        sp: CGFloat? = 0,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.align = align
        self.content = content()
        self.spacing = sp
    }

    var body: some View {
        HStack(alignment: align, spacing: spacing) { content }
    }
}

struct Z<Content: View>: View {
    private let align: Alignment
    let content: Content

    init(
        _ align: Alignment = .center,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.align = align
        self.content = content()
    }

    var body: some View {
        ZStack(alignment: align) { content }
    }
}
// swiftlint:enable type_name
