
import Foundation
import Interfaces
import UIKit

public final class CoreManager {
    
    private let interfaces: Interfaces
    private let applicationStateManager: ApplicationStateManager
    
    // MARK: - Init
    
    public init(interfaces: Interfaces,
                stateManagerContext: ApplicationStateManager.ApplicationStateManagerContext) {
        self.interfaces = interfaces
        applicationStateManager = .init(interfaces: interfaces,
                                        stateManagerContext: stateManagerContext)
    }
    
    // MARK: - Public
    
    public func set(window: UIWindow?) {
        applicationStateManager.set(window: window)
    }

    public func launchApplication() {
        interfaces.bootstrapInterface.fetchBootstrap()
    }
}
