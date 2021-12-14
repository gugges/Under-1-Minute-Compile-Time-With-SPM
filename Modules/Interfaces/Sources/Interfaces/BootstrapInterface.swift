
import Foundation

public protocol BootstrapInterface: AnyObject {
    var accessToken: String? { get }
    var willFetchBootstrap: (() -> Void)? { get set }
    var didFetchBootstrap: ((_ isLoggedIn: Bool) -> Void)? { get set }
    
    func fetchBootstrap()
    func set(accessToken: String?)
}
