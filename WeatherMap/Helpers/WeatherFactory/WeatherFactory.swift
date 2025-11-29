import Foundation

/// A factory protocol for building views with their associated view models.
///
/// The factory creates the view model internally using the provided context
/// and injects it into the view.
///
/// Usage:
/// ```swift
/// struct ProfileFactory: Factory {
///     typealias Context = UserID
///     typealias View = ProfileView
///     typealias ViewModel = ProfileViewModel
///
///     func build(from context: UserID) -> ProfileView {
///         let viewModel = ProfileViewModel(userID: context)
///         return ProfileView(viewModel: viewModel)
///     }
/// }
///
/// // Router usage:
/// router.push(ProfileFactory().build(from: userID))
/// ```
public protocol Factory {
    associatedtype Context
    associatedtype View
    associatedtype ViewModel
    
    /// Creates a view with its view model using the provided context.
    /// - Parameter context: The data required to construct the view model.
    /// - Returns: A fully configured view instance.
    func build(from context: Context) -> View
}
