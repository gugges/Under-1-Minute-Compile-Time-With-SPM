
import Foundation

/// The interfaces that are used by modules to implement a feature
public protocol Interfaces {
    
    /// logInterface: Used for logging
    var logInterface: LogInterface { get }

    /// networkInterface: Used to make rest api requests
    var networkInterface: NetworkInterface { get }

    /// routeInterface: Used for routing
    var routeInterface: RouteInterface { get }
    
    /// bootstrapInterface: Used for fetching application state information
    var bootstrapInterface: BootstrapInterface { get }
    
    /// experimentInterface: Used for toggling new feature experiments
    var experimentInterface: ExperimentInterface { get }
}

public protocol StandardRouteResponder: RouteRequestResponder {
    init(interfaces: Interfaces)
}
