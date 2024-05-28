//
//  ViewController.swift
//  Chapter 41 Exercise
//
//  Created by mrgsdev on 28.05.2024
//

import UIKit
import SpriteKit
import ARKit

enum BirdType: Int {
    case fat
    case blue
    case grumpy
    case flying
    
    var prefix: String {
        switch self {
        case .fat: return "fatbird"
        case .blue: return "bluebird"
        case .grumpy: return "grumpybird"
        case .flying: return "flyingbird"
        }
    }
    
    private static let count: Int = {
        var max: Int = 0
        while let _ = BirdType(rawValue: max) { max += 1 }
        return max
    }()
    
    static func random() -> BirdType {
        let randomNumber = Int.random(in: 0..<BirdType.count)
        return BirdType(rawValue: randomNumber)!
    }
    
    func keyFrames() -> [SKTexture] {
        var textures: [SKTexture] = []
        for index in 1...8 {
            textures.append(SKTexture(imageNamed: "\(self.prefix)-\(index)"))
        }
        
        return textures
    }
}


class ViewController: UIViewController, ARSKViewDelegate {
    
    @IBOutlet var sceneView: ARSKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and node count
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true
        
        // Load the SKScene from 'Scene.sks'
        if let scene = SKScene(fileNamed: "Scene") {
            sceneView.presentScene(scene)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSKViewDelegate
    
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        let birdType = BirdType.random()
        let birdFrames = birdType.keyFrames()
        
        let spriteNode = SKSpriteNode(texture: birdFrames[0])
        spriteNode.position = CGPoint(x: view.center.x, y: view.center.y)
        spriteNode.size = CGSize(width: spriteNode.size.width * 0.1, height: spriteNode.size.height * 0.1)
        
        let flyingAction = SKAction.repeatForever(SKAction.animate(with: birdFrames, timePerFrame: 0.1))
       
        spriteNode.run(flyingAction)
        
        return spriteNode
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
