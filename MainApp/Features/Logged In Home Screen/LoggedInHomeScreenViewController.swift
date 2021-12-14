
import Interfaces
import UIKit

final class LoggedInHomeScreenViewController: UITabBarController {
    
    private let interfaces: Interfaces?
    
    // MARK: - Init
    
    init(interfaces: Interfaces?) {
        self.interfaces = interfaces
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barStyle = .black
        tabBar.tintColor = .white
        
        // Prevents the weird behavior where the translucency disappears when you scroll to the edge
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
        
        title = "Discover"
        
        let discoverItem: UITabBarItem = .init(title: "Discover", image: UIImage(systemName: "sparkles.tv"), tag: 0)
        let physicsItem: UITabBarItem = .init(title: "Physics", image: UIImage(systemName: "atom"), tag: 1)
        let settingsItem: UITabBarItem = .init(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
        
        let items: [UITabBarItem] = [discoverItem, physicsItem, settingsItem]
        let routes: [Route] = [.discover, .physics, .settings]
        
        viewControllers = zip(items, routes).compactMap {
            guard let viewController = interfaces?.routeInterface.viewController(for: $0.1) else { return nil }
            
            let navigationController: UINavigationController = .init(rootViewController: viewController)
            navigationController.tabBarItem = $0.0
            
            return navigationController
        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        interfaces?.logInterface.debug("User selected tab \(item.tag + 1)")
    }
    
}
