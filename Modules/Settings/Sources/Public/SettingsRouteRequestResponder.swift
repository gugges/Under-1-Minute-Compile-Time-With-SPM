import Interfaces
import SwiftUI

public struct SettingsRouteRequestResponder: StandardRouteResponder {
    
    private let interfaces: Interfaces
    
    public init(interfaces: Interfaces) {
        self.interfaces = interfaces
    }

    public func viewController(for route: Route) -> UIViewController? {
        switch route {
        case .settings:
            return UIHostingController(rootView: SettingsView(interfaces: interfaces))
            
        default:
            return nil
        }
    }

}
