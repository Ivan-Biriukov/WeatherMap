import SwiftUI

extension ToolbarContent {
    /// Hides the shared glass background from toolbar items on iOS 26+.
    @ToolbarContentBuilder
    func removeGlass() -> some ToolbarContent {
        if #available(iOS 26.0, *) {
            self.sharedBackgroundVisibility(.hidden)
        } else {
            self
        }
    }}
