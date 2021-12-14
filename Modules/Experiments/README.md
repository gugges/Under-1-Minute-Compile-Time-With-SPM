# Experiments

## About

The experiment module is used for the enabling of feature flags within your application. The experiment types are defined as an enum in the Interfaces module alongside the protocol for the ExperimentInterface.

## Usage

```swift

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

```
