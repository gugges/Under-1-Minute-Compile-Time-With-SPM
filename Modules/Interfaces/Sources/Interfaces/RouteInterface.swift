
import UIKit

/// The supported routes
public enum Route {
    
    /// Login flow
    case login(onLoginSuccess: (_ accessToken: String) -> Void)

    /// Logged in home screen flow
    case loggedInHomeScreen
    
    /// Discover new things!
    case discover
    
    /// Physics simulator
    case physics
    
    /// Settings
    case settings
}

/// Interface used to make routing requests
public protocol RouteInterface: RouteRequestResponder {
    
    func add(interfaces: Interfaces, standardRouteRequestResponders: [StandardRouteResponder.Type])
    
    /// Removes all route request responders and associated routes
    func removeAllRoutes()
}
