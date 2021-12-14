
import Interfaces
import SwiftUI
import UIKit

struct LoadingApplicationState: ApplicationStateManaging {
    
    init(interfaces: Interfaces,
         updateRootViewController: (UIViewController) -> Void) {
        
        updateRootViewController(UIHostingController(rootView: LoadingView()))
    }
}
