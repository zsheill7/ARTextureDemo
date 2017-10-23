//
//  ViewController.swift
//  ARTextureDemo
//
//  Created by Zoe on 10/20/17.
//  Copyright © 2017 Zoe. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import SceneKit.ModelIO

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        //let scene = SCNScene(named: "art.scnassets/ship.scn")!
        let scene = SCNScene()
        
        let geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.0)
        let boxNode = SCNNode(geometry: geometry)
        boxNode.position = SCNVector3Make(0, 0, -0.5)
        let numFaces = 6
        
        
        let bundle = Bundle.main
        let path = bundle.path(forResource: "Boot_Shoot", ofType: "obj")
        let url = NSURL(fileURLWithPath: path!)
        let asset = MDLAsset(url: url as URL)
        let object = asset.object(at: 0)
        let shoeNode = SCNNode(mdlObject: object)
        shoeNode.position = SCNVector3(-50, -50, 1)
        //shoeNode.scale = SCNVector3(0.01, 0.01, 0.01)
        
        //scene.rootNode.addChildNode(boxNode)
        scene.rootNode.addChildNode(shoeNode)
        //let checkerImage = UIImage(named: "ShuttleDiffuseMap_.jpg")
        let checkerImage = UIImage(named: "brownboot.jpg")
        //let materialProp = SCNMaterialProperty(contents: checkerImage)
        // create and configure a material for each face
        var materials: [SCNMaterial] = Array()

        let material = SCNMaterial()
        material.diffuse.contents = checkerImage
        materials.append(material)
        
        /*for i in 1...numFaces
        {
            let material = SCNMaterial()
            material.diffuse.contents = checkerImage
            materials.append(material)
        }*/
        
        // set the material to the 3d object geometry
        shoeNode.geometry?.materials = materials

        
        // Set the scene to the view
        sceneView.scene = scene
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
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
