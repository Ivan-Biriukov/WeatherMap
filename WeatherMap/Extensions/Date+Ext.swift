import Foundation

extension Date {
    func stringFormattedDate(using pattern: String = "dd/MM/yyyy HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = pattern
        return formatter.string(from: self)
    }
}
