import Foundation

extension Date.FormatStyle {
    public static var custom: Date.FormatStyle {
        Date.FormatStyle()
            .day(.defaultDigits)
            .month(.wide)
            .weekday(.wide)
            .locale(Locale(identifier: "ru_RU"))
    }
}
