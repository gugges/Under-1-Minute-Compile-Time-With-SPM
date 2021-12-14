
import Interfaces
import SwiftUI

public struct LoginRouteRequestResponder: StandardRouteResponder {
    
    private let interfaces: Interfaces
    
    public init(interfaces: Interfaces) {
        self.interfaces = interfaces
    }

    public func viewController(for route: Route) -> UIViewController? {
        switch route {
        case .login(let onLoginSuccess):
            return UIHostingController(rootView: LoginView(interfaces: interfaces,
                                                           onLoginSuccess: onLoginSuccess))
            
        default:
            return nil
        }
    }

}
