# Routing

## About

The utility for communicating between loosely coupled features in the application. Routing can also be used for the passing of information via the Route enum type's associated values. Routing in this example is used to return a UIViewController, but can also be extended to pass SwiftUI `View`, UIKit `UIView`, `UIImage` and other types of assets that may be used by multiple modules. 

## Usage

```swift

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

```
