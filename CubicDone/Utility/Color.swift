import SwiftUI
import UIKit

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }

    var R: Double {
        var red = CGFloat()

        let uiColor = UIColor(self)
        uiColor.getRed(&red, green: nil, blue: nil, alpha: nil)

        return Double(red)
    }

    var G: Double {
        var green = CGFloat()

        let uiColor = UIColor(self)
        uiColor.getRed(nil, green: &green, blue: nil, alpha: nil)

        return Double(green)
    }

    var B: Double {
        var blue = CGFloat()

        let uiColor = UIColor(self)
        uiColor.getRed(nil, green: nil, blue: &blue, alpha: nil)

        return Double(blue)
    }
}

extension UIColor {
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex >> 16) & 0xff) / 255,
            green: CGFloat((hex >> 8) & 0xff) / 255,
            blue: CGFloat(hex & 0xff) / 255,
            alpha: alpha
        )
    }
}
