
import Interfaces
import Login
import UIKit

struct LoggedOutApplicationState: ApplicationStateManaging {
    
    init(interfaces: Interfaces,
         updateRootViewController: (UIViewController) -> Void) {
        
        interfaces.routeInterface.add(interfaces: interfaces,
                                      standardRouteRequestResponders: [LoginRouteRequestResponder.self])
        
        let loginRoute: Route = .login { accessToken in
            interfaces.bootstrapInterface.set(accessToken: accessToken)
            interfaces.bootstrapInterface.fetchBootstrap()
        }
        
        guard let rootViewController = interfaces.routeInterface.viewController(for: loginRoute) else {
            assertionFailure("No root view controller for logged out state!")
            return
        }
        
        updateRootViewController(rootViewController)
    }
}

