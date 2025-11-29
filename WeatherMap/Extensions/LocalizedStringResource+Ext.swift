import Foundation

extension LocalizedStringResource {
    /// Converts the localized string resource to a resolved `String` value.
    var resolved: String {
        String(localized: self)
    }
}
