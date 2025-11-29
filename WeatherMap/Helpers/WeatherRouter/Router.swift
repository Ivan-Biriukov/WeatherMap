import Foundation
import SwiftUI

/// A type that represents a single navigation destination for a flow.
///
/// Conformances define which view should be presented when the destination
/// is navigated to within a `Router`.
///
/// Use this protocol to unify all possible navigation endpoints for a given
/// flow into a single enum.
///
/// Example:
/// ```swift
/// enum ExampleFlow: NavigationDestination {
///     case main
///     case chat
///
///     var destinationView: some View {
///         switch self {
///         case .main: MainView()
///         case .chat: ChatView()
///         }
///     }
/// }
/// ```
protocol NavigationDestination {
    /// The associated SwiftUI view that represents the destination screen.
    associatedtype Destination: View

    /// The SwiftUI view to be displayed when navigating to this destination.
    @ViewBuilder
    var destinationView: Destination { get }
}

@Observable
/// A generic navigation router that manages a navigation path for a given flow.
///
/// `Router` maintains a stack of destinations and provides convenience
/// methods for forward and backward navigation. This is intended to be
/// integrated with SwiftUI’s `NavigationStack`.
///
/// Example usage:
/// ```swift
/// @StateObject private var router = ExampleFlowRouter()
///
/// var body: some View {
///     NavigationStack(path: $router.path) {
///         MainView()
///             .navigationDestination(for: ExampleFlow.self) { flow in
///                 flow.destinationView
///             }
///     }
/// }
/// ```
///
/// - Note: This router uses a simple array-based stack to represent the navigation path.
final class Router<Destination: NavigationDestination> {
    
    /// The navigation stack path holding pushed destinations.
    var path: [Destination] = []
    
    /// Pushes a new destination onto the navigation stack.
    /// - Parameter destination: The destination to navigate to.
    func navigate(to destination: Destination) {
        path.append(destination)
    }
    
    /// Pops the last destination off the navigation stack.
    ///
    /// If the path is already empty, this method has no effect.
    func back() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    /// Clears the entire navigation stack, returning to the root.
    func navigateRoot() {
        path.removeAll()
    }
}
