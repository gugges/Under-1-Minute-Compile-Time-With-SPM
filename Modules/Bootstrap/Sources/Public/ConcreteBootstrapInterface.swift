
import Foundation
import Interfaces

public final class ConcreteBootstrapInterface: BootstrapInterface {
    
    public var willFetchBootstrap: (() -> Void)?
    public var didFetchBootstrap: ((_ isLoggedIn: Bool) -> Void)?
    public private(set) var accessToken: String?
    
    // MARK: - Init
    
    public init(networkInterface: NetworkInterface) {
        // We aren't actually using the networkInterface but this is so you can see how to inject it
    }
    
    // MARK: - Fetch
    
    public func fetchBootstrap() {
        willFetchBootstrap?()
        
        let artificalDelay: TimeInterval = accessToken == nil ? 2 : 0
        
        // This is where your app state networking would go
        DispatchQueue.main.asyncAfter(deadline: .now() + artificalDelay) {
            self.didFetchBootstrap?(self.accessToken != nil)
        }
    }
    
    public func set(accessToken: String?) {
        self.accessToken = accessToken
    }
}
