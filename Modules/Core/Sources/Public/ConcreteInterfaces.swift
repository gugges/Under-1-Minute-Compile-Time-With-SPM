
import Foundation
import Interfaces

public final class ConcreteInterfaces: Interfaces {
    
    public let logInterface: LogInterface
    public let networkInterface: NetworkInterface
    public let routeInterface: RouteInterface
    public let bootstrapInterface: BootstrapInterface
    public let experimentInterface: ExperimentInterface
    
    public init(logInterface: LogInterface,
                networkInterface: NetworkInterface,
                routeInterface: RouteInterface,
                bootstrapInterface: BootstrapInterface,
                experimentInterface: ExperimentInterface) {
        self.logInterface = logInterface
        self.networkInterface = networkInterface
        self.routeInterface = routeInterface
        self.bootstrapInterface = bootstrapInterface
        self.experimentInterface = experimentInterface
    }
}
