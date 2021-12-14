
import Interfaces
import UIKit

struct LoadingApplicationState: ApplicationStateManaging {
    
    init(interfaces: Interfaces,
         updateRootViewController: (UIViewController) -> Void) {
        
        updateRootViewController(UIViewController())
    }
}
