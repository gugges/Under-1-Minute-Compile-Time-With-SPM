
import Foundation
import UIKit

public protocol ApplicationStateManaging {
    
    init(interfaces: Interfaces,
         updateRootViewController: (UIViewController) -> Void)
}
