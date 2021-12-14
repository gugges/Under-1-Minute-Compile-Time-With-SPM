
import UIKit

/// Libraries can conform to this protocol to provide ViewController without explicitly writing a factory method
public protocol RouteRequestResponder {
    
    /// Used to provide viewControllers to the router.
    /// If this responder can it will return the viewController for the route
    ///
    /// - Parameters:
    ///   - route: The route
    ///
    /// - Returns: The viewController for the route
    func viewController(for route: Route) -> UIViewController?
}
