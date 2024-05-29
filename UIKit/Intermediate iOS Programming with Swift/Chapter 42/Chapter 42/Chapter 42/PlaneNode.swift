//
//  PlaneNode.swift
//  Chapter 42
//
//  Created by mrgsdev on 29.05.2024
//

import Foundation
import SceneKit
import ARKit

class PlaneNode: SCNNode {
    private var anchor: ARPlaneAnchor!
    private var plane: SCNPlane!
    
    init(anchor: ARPlaneAnchor) {
        super.init()
        
        self.anchor = anchor
        
        // Create a virtual plane to visualize the detected plane
        self.plane = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
        
        // Set the color of the virtual plane
        self.plane.materials.first?.diffuse.contents = UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 0.50)
        
        // Create the SceneKit plane node
        self.geometry = plane
        self.position = SCNVector3(anchor.center.x, 0.0, anchor.center.z)
        
        // Since the plane in SceneKit is vertical, we have to rotate it by 90 degrees
        // The value should be in the form of radian.
        self.eulerAngles.x = -Float.pi / 2.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func update(anchor: ARPlaneAnchor) {
        self.anchor = anchor
        
        // Update the plane's size
        plane.width = CGFloat(anchor.extent.x)
        plane.height = CGFloat(anchor.extent.z)
        
        // Update the plane's position
        self.position = SCNVector3(anchor.center.x, 0.0, anchor.center.z)
    }
}
