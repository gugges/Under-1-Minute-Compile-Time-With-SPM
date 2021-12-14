
import SpriteKit
import UIKit

final class NewPhysicsViewController: UIViewController {
    
    private let sceneView: SKView = .init()
    private let snowmanLabel: UILabel = .init()
    private let treeLabel: UILabel = .init()
    private let moonLabel: UILabel = .init()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupViews()
        setupLabels()
        setupParticleSystem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sceneView.scene?.isPaused = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.scene?.isPaused = true
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        view.backgroundColor = .systemBlue
        view.addSubview(treeLabel)
        view.addSubview(snowmanLabel)
        view.addSubview(moonLabel)
        view.addSubview(sceneView)
    
        snowmanLabel.translatesAutoresizingMaskIntoConstraints = false
        treeLabel.translatesAutoresizingMaskIntoConstraints = false
        moonLabel.translatesAutoresizingMaskIntoConstraints = false
        sceneView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sceneView.topAnchor.constraint(equalTo: view.topAnchor),
            sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            moonLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            moonLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            
            treeLabel.centerXAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            treeLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 45),
            
            snowmanLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            snowmanLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    private func setupLabels() {
        moonLabel.text = "🌕"
        moonLabel.font = .systemFont(ofSize: 150)
        
        treeLabel.text = "🌲"
        treeLabel.font = .systemFont(ofSize: 400)
        
        snowmanLabel.text = "⛄️"
        snowmanLabel.font = .systemFont(ofSize: 100)
    }
    
    private func setupParticleSystem() {
        let scene = SKScene(size: view.frame.size)
        scene.backgroundColor = .clear
        sceneView.backgroundColor = .clear
        
        guard let emitter = SKEmitterNode(fileNamed: "SnowParticleSystem") else { return }

        emitter.position = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height)
        
        scene.addChild(emitter)
        sceneView.presentScene(scene)
    }
    
}
