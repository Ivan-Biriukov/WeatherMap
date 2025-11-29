import Foundation
import SwiftUI

/// Convenience typealias for the router of `ExampleFlow`.
typealias ExampleFlowRouter = Router<ExampleFlow>


/// Example flow enum representing navigation endpoints in the app.
///
/// Each case corresponds to a screen that can be pushed in the navigation stack.
///
/// Usage:
/// ```swift
/// let router = ExampleFlowRouter()
/// router.navigate(to: .chat) // Pushes the ChatView
/// router.back()              // Returns to the previous screen
/// ```
enum ExampleFlow: NavigationDestination, Hashable {
    /// Main screen of the flow.
    case main
    /// Chat screen of the flow.
    case chat
    
    /// The destination SwiftUI view for each flow case.
    var destinationView: some View {
        switch self {
        case .main:
            Text("Main Screen")
        case .chat:
            Text("Chat Screen")
        }
    }
}

/// # Example Integration
///
/// ```swift
/// struct RootView: View {
///     @State private var router = ExampleFlowRouter()
///
///     var body: some View {
///         NavigationStack(path: $router.path) {
///             VStack {
///                 Button("Go to Chat") {
///                     router.navigate(to: .chat)
///                 }
///             }
///             .navigationDestination(for: ExampleFlow.self) { flow in
///                 flow.destinationView
///                   .environment(router)
///                   .navigationTransition(.zoom(sourceID: activeTransitionID, in: navNS))
///                   .toolbar(.hidden, for: .tabBar)
///             }
///         }
///     }
/// }
/// ```

