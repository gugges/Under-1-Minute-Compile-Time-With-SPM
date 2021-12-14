
import Interfaces
import UIKit

public final class ConcreteRouteInterface {
    
    private var routeRequestResponders: [RouteRequestResponder] = []

    // MARK: - Init

    public init() {}

    // MARK: - Public

    public func add(routeRequestResponder: RouteRequestResponder) {
        routeRequestResponders.append(routeRequestResponder)
    }

    public func add(interfaces: Interfaces, standardRouteRequestResponders: [StandardRouteResponder.Type]) {
        for responderType in standardRouteRequestResponders {
            let routeRequestResponder = responderType.init(interfaces: interfaces)
            add(routeRequestResponder: routeRequestResponder)
        }
    }
    
}

// MARK: - RoutingInterface

extension ConcreteRouteInterface: RouteInterface {
    
    public func viewController(for route: Route) -> UIViewController? {
        for routeRequestResponder in routeRequestResponders {
            if let viewController = routeRequestResponder.viewController(for: route) {
                return viewController
            }
        }

        return nil
    }
    
    public func removeAllRoutes() {
        routeRequestResponders.removeAll()
    }
    
}
