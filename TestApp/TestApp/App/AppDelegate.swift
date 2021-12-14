
import Bootstrap
import Core
import Experiments
import Interfaces
import Networking
import Routing
import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var coreManager: CoreManager?
    
    // MARK: - Lifecycle
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window: UIWindow = .init()
        self.window = window
        window.makeKeyAndVisible()
            
        coreManager = .init(interfaces: makeInterfaces(),
                            stateManagerContext: makeStateManagerContext())
        coreManager?.set(window: window)
        coreManager?.launchApplication()

        return true
    }

    // MARK: - Helpers
    
    private func makeInterfaces() -> Interfaces {
        let logInterface: MockLogInterface = .init()
        let networkInterface: ConcreteNetworkInterface = .init(logInterface: logInterface)
        let routeInterface: ConcreteRouteInterface = .init()
        let bootstrapInterface: ConcreteBootstrapInterface = .init(networkInterface: networkInterface)
        let experimentInterface: ConcreteExperimentInterface = .init(experiments: [.newPhysicsExperience: false])
        
        return ConcreteInterfaces(logInterface: logInterface,
                                  networkInterface: networkInterface,
                                  routeInterface: routeInterface,
                                  bootstrapInterface: bootstrapInterface,
                                  experimentInterface: experimentInterface)
    }
    
    private func makeStateManagerContext() -> ApplicationStateManager.ApplicationStateManagerContext {
        return .init(loading: LoadingApplicationState.self,
                     loggedIn: LoggedInApplicationState.self,
                     loggedOut: LoggedOutApplicationState.self)
    }

}
