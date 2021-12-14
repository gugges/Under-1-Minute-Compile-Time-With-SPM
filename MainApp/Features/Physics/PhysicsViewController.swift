
import CoreMotion
import UIKit

final class PhysicsViewController: UIViewController {
    
    private let logoImageView: UIImageView = .init(image: UIImage(named: "okcupid"))
    private let button: UIButton = .init(type: .custom)
    private let cloud1ImageView: UIImageView = .init(image: UIImage(named: "Cloud1"))
    private let cloud2ImageView: UIImageView = .init(image: UIImage(named: "Cloud2"))
    private let planeView: UIImageView = .init(image: UIImage(named: "adventurous-plane"))

    private var dynamicAnimator: UIDynamicAnimator?
    private let gravity: UIGravityBehavior = .init()
    private let collider: UICollisionBehavior = .init()
    private var colliderItems: Set<UUID> = .init()
    private let itemBehavior: UIDynamicItemBehavior = .init()
    private let motionQueue: OperationQueue = .init()
    private let motionManager: CMMotionManager = .init()

    // All image assets from the OkCupid Jay Daniel Wright Rebrand in 2017
    private let images: [UIImage] = [
        UIImage(named: "about-3-youbeyou"),
        UIImage(named: "admirer"),
        UIImage(named: "adventurous-bag"),
        UIImage(named: "adventurous-boot"),
        UIImage(named: "artsy-canvas"),
        UIImage(named: "cat-tastic-cat1"),
        UIImage(named: "cultured-globe"),
        UIImage(named: "cultured-passport"),
        UIImage(named: "foodie-burger"),
        UIImage(named: "geeky-gameboy"),
        UIImage(named: "lgbtq-flag"),
        UIImage(named: "nuturing-heart"),
        UIImage(named: "passionate-heart"),
        UIImage(named: "quirky-statue"),
        UIImage(named: "stoner-alien"),
        UIImage(named: "stoner-chips"),
        UIImage(named: "zen-yoga-2")
    ].compactMap { $0 }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupDynamics()
        setupPanGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        addPlaneAnimation()
        addCloudAnimation()
        setupCollisionBoundaries()
        
        motionManager.startDeviceMotionUpdates(to: motionQueue) { [weak self] deviceMotion, error in
            self?.gravityUpdated(motion: deviceMotion, error: error)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        motionManager.stopDeviceMotionUpdates()

        removePlaneAnimation()
        removeCloudAnimation()
    }
    
    // MARK: - Animations
    
    private func addCloudAnimation() {
        let angle: CGFloat = .pi * (10 / 180)
        
        UIView.animateKeyframes(withDuration: 5, delay: 0, options: [.repeat, .calculationModeLinear], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25, animations: {
                self.cloud1ImageView.transform = CGAffineTransform(rotationAngle: -angle)
                self.cloud2ImageView.transform = CGAffineTransform(rotationAngle: angle)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25, animations: {
                self.cloud1ImageView.transform = CGAffineTransform(rotationAngle: 0)
                self.cloud2ImageView.transform = CGAffineTransform(rotationAngle: 0)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25, animations: {
                self.cloud1ImageView.transform = CGAffineTransform(rotationAngle: angle)
                self.cloud2ImageView.transform = CGAffineTransform(rotationAngle: -angle)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25, animations: {
                self.cloud1ImageView.transform = CGAffineTransform(rotationAngle: 0)
                self.cloud2ImageView.transform = CGAffineTransform(rotationAngle: 0)
            })
        }, completion: nil)
    }
    
    private func removeCloudAnimation() {
        cloud1ImageView.layer.removeAllAnimations()
        cloud2ImageView.layer.removeAllAnimations()
    }
    
    private func addPlaneAnimation() {
        planeView.contentMode = .scaleAspectFit
        
        view.insertSubview(planeView, aboveSubview: cloud2ImageView)
        
        planeView.frame = CGRect(x: -80, y: 60, width: 80, height: 130)
        
        UIView.animate(withDuration: 15, delay: 2, options: [.repeat, .curveLinear], animations: {
            self.planeView.transform = CGAffineTransform(translationX: self.view.frame.size.width + 80 * 5, y: 0)
        }, completion: nil)
        
    }
    
    private func removePlaneAnimation() {
        planeView.removeFromSuperview()
        planeView.layer.removeAllAnimations()
    }
    
    // MARK: - UIGestureRecognizer
    
    @objc private func gestureRecognized(_ gestureRecognizer: UIPanGestureRecognizer) {
        let views: [EllipseImageView] = view.subviews.compactMap { $0 as? EllipseImageView }
        
        switch gestureRecognizer.state {
        case .began:
            dynamicAnimator?.removeBehavior(gravity)

        case .changed:
            applyPanPushBehavior(for: views, location: gestureRecognizer.location(in: view))
            
        case .ended:
            dynamicAnimator?.addBehavior(gravity)
            removePushBehaviors()
            
        default: ()
        }
    }
    
    private func applyPanPushBehavior(for views: [EllipseImageView], location: CGPoint) {
        let size: CGFloat = 20
        let originX: CGFloat = location.x - size / 2
        let originY: CGFloat = location.y - size / 2
        
        let hitBox: CGRect = CGRect(x: originX, y: originY, width: size, height: size)
        
        for view in views {
            if view.frame.intersects(hitBox) {
                addPush(for: view, touchPoint: location)
            }
        }
    }
    
    private func addPush(for subview: EllipseImageView, touchPoint: CGPoint) {
        let slopeX: CGFloat = subview.center.x - touchPoint.x
        let slopeY: CGFloat = subview.center.y - touchPoint.y
        let velo: CGFloat = 0.3
        
        let vectorX: CGFloat = slopeX > 0 ? velo : -velo
        let vectorY: CGFloat = slopeY > 0 ? velo : -velo
        let vector = CGVector(dx: vectorX, dy: vectorY)
        
        let pushBehavior: UIPushBehavior = .init(items: [subview], mode: .instantaneous)
        pushBehavior.pushDirection = vector
        
        dynamicAnimator?.addBehavior(pushBehavior)
    }
    
    private func removePushBehaviors() {
        guard let dynamicAnimator = dynamicAnimator else { return }
        
        for behavior in dynamicAnimator.behaviors {
            if behavior is UIPushBehavior {
                dynamicAnimator.removeBehavior(behavior)
            }
        }
    }
    
    // MARK: - Actions
    
    @objc private func didTapButton() {
        let views: [EllipseImageView] = view.subviews.compactMap { $0 as? EllipseImageView }
        
        removePushBehaviors()
        
        let pushBehavior = UIPushBehavior(items: views, mode: .instantaneous)
        pushBehavior.setAngle(.pi * 3/2, magnitude: 1.4)
        
        dynamicAnimator?.addBehavior(pushBehavior)
    }
    
    // MARK: - Device Motion
    
    func gravityUpdated(motion: CMDeviceMotion?, error: Error?) {
        guard let motion = motion else { return }
        
        let motionGravity = motion.gravity
        
        let x: CGFloat = CGFloat(motionGravity.x)
        let y: CGFloat = CGFloat(motionGravity.y)
        let p: CGPoint = CGPoint(x: x, y: y)
        
        let v = CGVector(dx: p.x, dy: 0 - p.y)
        
        DispatchQueue.main.async { [weak self] in
            self?.gravity.gravityDirection = v
        }
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        cloud1ImageView.translatesAutoresizingMaskIntoConstraints = false
        cloud2ImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(cloud1ImageView)
        view.addSubview(cloud2ImageView)
        view.addSubview(logoImageView)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            cloud1ImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 36),
            cloud1ImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            cloud1ImageView.widthAnchor.constraint(equalToConstant: 90),
            cloud1ImageView.heightAnchor.constraint(equalToConstant: 60),
            
            cloud2ImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 90),
            cloud2ImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            cloud2ImageView.widthAnchor.constraint(equalToConstant: 90),
            cloud2ImageView.heightAnchor.constraint(equalToConstant: 60),
            
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 64),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            button.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 100),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.backgroundColor = .systemBlue
        
        button.backgroundColor = .systemGreen
        button.clipsToBounds = true
        button.layer.cornerRadius = 3
        button.setTitle("Tap me", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    private func setupDynamics() {
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        
        collider.translatesReferenceBoundsIntoBoundary = true

        itemBehavior.friction = 0
        itemBehavior.elasticity = 0.5
        itemBehavior.resistance = 0.5
        itemBehavior.angularResistance = 0.5
        
        dynamicAnimator?.addBehavior(gravity)
        dynamicAnimator?.addBehavior(collider)
        dynamicAnimator?.addBehavior(itemBehavior)
    
        var frames = [CGRect]()
        
        for index in 0..<images.count {
            
            let image = images[index]
            
            let imageView = EllipseImageView()
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            
            view.addSubview(imageView)
            
            let aspectRatio: CGFloat = image.size.height / image.size.width
            let desiredSize: CGFloat = 50
            let desiredSizeTall: CGFloat = 60
            
            let width: CGFloat = aspectRatio > 1 ? desiredSizeTall : desiredSize / aspectRatio
            let height: CGFloat = aspectRatio > 1 ? desiredSizeTall * aspectRatio : desiredSize
            
            let frame: CGRect
            
            // Insert the items above the screen and line them up horizontally
            // Then give them gravity and have them rain down into the view
            if let lastFrame = frames.last {
                var originX: CGFloat = lastFrame.maxX
                
                if lastFrame.maxX + width >= view.frame.size.width {
                    originX = 0
                }
                
                frame = CGRect(x: originX, y: -200, width: width, height: height)
                
            } else {
                frame = CGRect(x: 0, y: -200, width: width, height: height)
            }
            
            frames.append(frame)
            
            imageView.frame = frame
            
            // Make the images rain in from the top of the screen in succession
            DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(index) * 0.1) { [weak self] in
                let pushBehavior = UIPushBehavior(items: [imageView], mode: .instantaneous)
                pushBehavior.setAngle(.pi / 2, magnitude: 0.5)
                pushBehavior.addItem(imageView)
                
                self?.dynamicAnimator?.addBehavior(pushBehavior)
                self?.gravity.addItem(imageView)
                self?.itemBehavior.addItem(imageView)
            }
        }
        
        gravity.action = { [weak self] in
            guard let self = self else { return }

            for subview in self.view.subviews {
                guard let subview = subview as? EllipseImageView else { continue }

                // Once inside the frame add boundaries
                if subview.frame.origin.y > 0 && !self.colliderItems.contains(subview.id) {
                    self.collider.addItem(subview)
                    self.colliderItems.insert(subview.id)
                    
                } else if subview.frame.origin.y > self.view.frame.maxY {
                    self.colliderItems.remove(subview.id)
                    self.gravity.removeItem(subview)
                    self.collider.removeItem(subview)
                    self.itemBehavior.removeItem(subview)

                    subview.removeFromSuperview()
                }
            }
        }
    }
    
    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(gestureRecognized))
        view.addGestureRecognizer(panGesture)
    }
    
    private func setupCollisionBoundaries() {
        guard collider.boundaryIdentifiers == nil else { return }
        
        let safeAreaBottomFrame: CGRect = .init(x: 0,
                                                y: view.frame.maxY - view.safeAreaInsets.bottom + 2,
                                                width: view.frame.width,
                                                height: view.safeAreaInsets.bottom)
        
        collider.addBoundary(withIdentifier: "logo" as NSString, for: UIBezierPath(rect: logoImageView.frame))
        collider.addBoundary(withIdentifier: "button" as NSString, for: UIBezierPath(rect: button.frame))
        collider.addBoundary(withIdentifier: "floor" as NSString, for: UIBezierPath(rect: safeAreaBottomFrame))
    }

}

private final class EllipseImageView: UIImageView {
    
    let id: UUID = .init()
    
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .ellipse
    }
}
