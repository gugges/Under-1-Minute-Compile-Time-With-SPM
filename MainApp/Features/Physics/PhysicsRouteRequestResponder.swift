
import Interfaces
import UIKit

public struct PhysicsRouteRequestResponder: StandardRouteResponder {
    
    private let interfaces: Interfaces
    
    public init(interfaces: Interfaces) {
        self.interfaces = interfaces
    }

    public func viewController(for route: Route) -> UIViewController? {
        switch route {
        case .physics:
            return PhysicsViewController()
            
        default:
            return nil
        }
    }

}


