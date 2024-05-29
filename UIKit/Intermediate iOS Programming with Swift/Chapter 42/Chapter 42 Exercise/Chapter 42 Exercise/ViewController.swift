//
//  ViewController.swift
//  Chapter 42 Exercise
//
//  Created by mrgsdev on 29.05.2024
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!
    
    private var planes: [ UUID: PlaneNode ] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        sceneView.delegate = self
        sceneView.debugOptions = [ ARSCNDebugOptions.showFeaturePoints ]
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addRobot(recognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    @objc func addRobot(recognizer: UITapGestureRecognizer) {
        let tapLocation = recognizer.location(in: sceneView)
        
        guard let query = sceneView.raycastQuery(from: tapLocation, allowing: .existingPlaneInfinite, alignment: .horizontal) else {
            return
        }
        
        let hitResults = sceneView.session.raycast(query)
        
        guard let hitResult = hitResults.first else {
            return
        }
        
        guard let scene = SCNScene(named: "art.scnassets/Hip Hop Dance.dae") else {
            return
        }
        
        let node = SCNNode()
        for childNode in scene.rootNode.childNodes {
            node.addChildNode(childNode)
        }
        
        node.pivot = SCNMatrix4MakeTranslation(0.0, 0.0, 0.0)
        node.position = SCNVector3(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)
        node.scale = SCNVector3(0.001, 0.001, 0.001)
        
        sceneView.scene.rootNode.addChildNode(node)
        
    }
}

extension ViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {

        if let planeAnchor = anchor as? ARPlaneAnchor {
        
            let planeNode = PlaneNode(anchor: planeAnchor)
            
            planes[anchor.identifier] = planeNode
            node.addChildNode(planeNode)
        }
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as?  ARPlaneAnchor, let plane = planes[planeAnchor.identifier] else {
            return
        }
        
        plane.update(anchor: planeAnchor)
    }
}
