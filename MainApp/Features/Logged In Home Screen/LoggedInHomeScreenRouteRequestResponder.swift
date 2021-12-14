
import Interfaces
import UIKit

public struct LoggedInHomeScreenRouteRequestResponder: StandardRouteResponder {
    
    private let interfaces: Interfaces
    
    public init(interfaces: Interfaces) {
        self.interfaces = interfaces
    }

    public func viewController(for route: Route) -> UIViewController? {
        switch route {
        case .loggedInHomeScreen:
            return LoggedInHomeScreenViewController(interfaces: interfaces)
            
        default:
            return nil
        }
    }

}

