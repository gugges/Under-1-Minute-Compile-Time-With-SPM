
import Foundation
import Interfaces
import UIKit

public final class ApplicationStateManager {
    
    public enum ApplicationState {
        case loading
        case loggedOut
        case loggedIn
    }
    
    public struct ApplicationStateManagerContext {
        let loading: ApplicationStateManaging.Type
        let loggedIn: ApplicationStateManaging.Type
        let loggedOut: ApplicationStateManaging.Type
        
        public init(loading: ApplicationStateManaging.Type,
                    loggedIn: ApplicationStateManaging.Type,
                    loggedOut: ApplicationStateManaging.Type) {
            self.loading = loading
            self.loggedIn = loggedIn
            self.loggedOut = loggedOut
        }
    }
    
    private var state: ApplicationState = .loading {
        didSet {
            stateDidChange()
        }
    }
    
    private let interfaces: Interfaces
    private weak var window: UIWindow?
    private let stateManagerContext: ApplicationStateManagerContext
    private var activeStateManager: ApplicationStateManaging?
    
    // MARK: - Init
    
    init(interfaces: Interfaces,
         stateManagerContext: ApplicationStateManagerContext) {
        self.interfaces = interfaces
        self.stateManagerContext = stateManagerContext
        
        interfaces.bootstrapInterface.willFetchBootstrap = { [weak self] in
            guard self?.interfaces.bootstrapInterface.accessToken == nil else { return }
            
            self?.state = .loading
        }
        
        interfaces.bootstrapInterface.didFetchBootstrap = { [weak self] isLoggedIn in
            self?.state = isLoggedIn ? .loggedIn : .loggedOut
        }
    }
    
    // MARK: - Internal
    
    func set(window: UIWindow?) {
        self.window = window
    }
    
    func set(state: ApplicationState) {
        self.state = state
    }
    
    // MARK: - Helpers
    
    private func stateDidChange() {
        interfaces.routeInterface.removeAllRoutes()
        
        let stateManagerType: ApplicationStateManaging.Type
        
        switch state {
        case .loading:
            stateManagerType = stateManagerContext.loading
            
        case .loggedIn:
            stateManagerType = stateManagerContext.loggedIn
            
        case .loggedOut:
            stateManagerType = stateManagerContext.loggedOut
        }
        
        activeStateManager = stateManagerType.init(interfaces: interfaces) { [weak self] viewController in
            guard let window = self?.window else { return }

            UIView.transition(with: window, duration: 0.35, options: .transitionFlipFromLeft) {
                window.rootViewController = viewController
                
            } completion: { _ in }
        }
    }
    
}
