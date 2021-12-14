
import Interfaces
import UIKit

public struct NewPhysicsRouteRequestResponder: StandardRouteResponder {
    
    private let interfaces: Interfaces
    
    public init(interfaces: Interfaces) {
        self.interfaces = interfaces
    }

    public func viewController(for route: Route) -> UIViewController? {
        switch route {
        case .physics:
            guard interfaces.experimentInterface.isActive(experiment: .newPhysicsExperience) else {
                return nil
            }
            return NewPhysicsViewController()
            
        default:
            return nil
        }
    }

}
