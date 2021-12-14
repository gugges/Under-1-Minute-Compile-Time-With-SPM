
import Discover
import Interfaces
import UIKit

struct LoggedInApplicationState: ApplicationStateManaging {
    
    init(interfaces: Interfaces,
         updateRootViewController: (UIViewController) -> Void) {
        
        interfaces.routeInterface.add(interfaces: interfaces,
                                      standardRouteRequestResponders: [DiscoverRouteRequestResponder.self])
        
        guard let rootViewController = interfaces.routeInterface.viewController(for: .discover) else {
            assertionFailure("No root view controller for logged in state!")
            return
        }
        
        updateRootViewController(rootViewController)
    }
}
