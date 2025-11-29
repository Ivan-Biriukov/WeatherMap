import SwiftUI
import PhotosUI

//MARK: - Properties
extension View {
    var isSmallScreen: Bool {
        UIScreen.main.bounds.height < 700
    }
    
    var isLargeScreen: Bool {
        UIScreen.main.bounds.height > 900
    }
    
    var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
}

//MARK: - Methods
extension View {
    func isAvailable(iOS version: Int) -> Bool {
        if #available(iOS 26, *) {
            return ProcessInfo.processInfo.operatingSystemVersion.majorVersion >= version
        }
        return ProcessInfo.processInfo.operatingSystemVersion.majorVersion >= version
    }
    
    func openLink(_ link: String) {
        if let privacyURL = URL(string: link) {
            UIApplication.shared.open(privacyURL)
        }
    }
}

//MARK: - UI Elements / modifiers
extension View {
    @ViewBuilder
    func hSpacing(_ alignment: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    @ViewBuilder
    func vSpacing(_ alignment: Alignment) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
    
    /// Applies horizontal spacing only on iOS versions below 26.
    /// - Parameter alignment: The alignment to apply within the expanded frame.
    @ViewBuilder
    func toolBarSpacing(_ alignment: Alignment) -> some View {
        if #available(iOS 26, *) {
            self
        } else {
            self
                .frame(maxWidth: .infinity, alignment: alignment)
        }
    }
    
    /// - Parameters:
    ///   - shape: The shape to use for the glass effect.
    ///   - interactive: When `true`, enables highlight effect on touch. Default is `false`.
    @ViewBuilder
    func glassedEffect(
        in shape: some Shape,
        interactive: Bool = false
    ) -> some View {
        if #available(iOS 26, *) {
            if interactive {
                self.glassEffect(.regular.interactive(), in: shape)
            } else {
                self.glassEffect(in: shape)
            }
        } else {
            self.background {
                shape.glassed()
            }
        }
    }
    
    /// Applies a glass material effect with customizable appearance.
    /// - Parameters:
    ///   - shape: The shape to use for the glass effect.
    ///   - isClear: When `true`, uses a transparent glass style. Default is `false`.
    ///   - tint: Optional tint color to apply to the glass effect.
    ///   - interactive: When `true`, enables highlight effect on touch. Default is `false`.
    @ViewBuilder
    func glassedEffect(
        in shape: some Shape,
        isClear: Bool = false,
        tint: Color? = nil,
        interactive: Bool = false
    ) -> some View {
        if #available(iOS 26, *) {
            if interactive {
                self.glassEffect(isClear ? .clear.interactive().tint(tint) : .regular.interactive().tint(tint), in: shape)
            } else {
                self.glassEffect(isClear ? .clear.tint(tint) : .regular.tint(tint), in: shape)
            }
        } else {
            self
                .background(tint)
                .clipShape(shape)
                .background {
                    shape.glassed()
                }
        }
    }
    
    @ViewBuilder
    func mainButtonStyle(tint: Color = .accentColor) -> some View {
        if #available(iOS 26, *) {
            self
                .tint(tint)
                .buttonStyle(.glassProminent)
        } else {
            self
                .background(tint)
                .clipShape(.capsule)
                .background { Capsule().glassed() }
        }
    }
    
    /// Clips the view using concentric corner style on iOS 26+, falls back to standard rounded corners.
    @ViewBuilder
    func clipShapeConcentric() -> some View {
        if #available(iOS 26.0, *) {
            self
                .clipShape(.rect(corners: .concentric, isUniform: true))
        } else {
            self
                .clipShape(.rect(cornerRadius: 16))
        }
    }
    
    /// Enables tab bar auto-minimize behavior when scrolling down on iOS 26+.
    @ViewBuilder
    func minimizeTabBarSize() -> some View {
        if #available(iOS 26, *) {
            self.tabBarMinimizeBehavior(.onScrollDown)
        } else {
            self
        }
    }
    
    func cornerRad(_ cornerRadius: CGFloat, corners: UIRectCorner = .allCorners) -> some View {
        clipShape(CustomRectangle(cornerRadius: cornerRadius, corners: corners))
    }
    
    /// Sets a custom background for TextEditor by hiding default scroll background.
    /// - Parameter content: The view to use as background.
    func textEditorBackground<Background: View>(_ content: Background) -> some View {
        return self
            .scrollContentBackground(.hidden)
            .background(content)
    }
}

//MARK: - Private modifiers
fileprivate struct CustomRectangle: Shape {
    let cornerRadius: CGFloat
    let corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        Path(UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        ).cgPath)
    }
}
