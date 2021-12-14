
import Interfaces
import UIKit

public struct DiscoverRouteRequestResponder: StandardRouteResponder {
    
    private let interfaces: Interfaces
    
    public init(interfaces: Interfaces) {
        self.interfaces = interfaces
    }

    public func viewController(for route: Route) -> UIViewController? {
        switch route {
        case .discover:
            return DiscoverViewController(interfaces: interfaces)
            
        default:
            return nil
        }
    }

}
