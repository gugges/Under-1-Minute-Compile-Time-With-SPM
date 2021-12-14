
import Discover
import Interfaces
import Settings
import UIKit

struct LoggedInApplicationState: ApplicationStateManaging {
    
    init(interfaces: Interfaces,
         updateRootViewController: (UIViewController) -> Void) {
        
        interfaces.routeInterface.add(interfaces: interfaces,
                                      standardRouteRequestResponders: [DiscoverRouteRequestResponder.self,
                                                                       LoggedInHomeScreenRouteRequestResponder.self,
                                                                       NewPhysicsRouteRequestResponder.self,
                                                                       PhysicsRouteRequestResponder.self,
                                                                       SettingsRouteRequestResponder.self])
        
        guard let rootViewController = interfaces.routeInterface.viewController(for: .loggedInHomeScreen) else {
            assertionFailure("No root view controller for logged in state!")
            return
        }
        
        updateRootViewController(rootViewController)
    }
}
