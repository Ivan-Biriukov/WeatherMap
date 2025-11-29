import SwiftUI

extension Shape {
    /// Applies a glass-like material effect with subtle gradient overlay and border.
    /// Use as fallback for iOS versions below 26 where native glass effects are unavailable.
    func glassed() -> some View {
        self
            .fill(.ultraThinMaterial)
            .fill(
                .linearGradient(
                    colors: [
                        .primary.opacity(0.008),
                        .primary.opacity(0.005),
                        .primary.opacity(0.001),
                        .clear,
                        .clear,
                        .clear
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .stroke(.primary.opacity(0.2), lineWidth: 0.7)
    }
}
