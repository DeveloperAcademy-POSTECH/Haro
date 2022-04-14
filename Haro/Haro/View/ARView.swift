//
//  ARView.swift
//  Haro
//
//  Created by Moon Jongseek on 2022/04/13.
//

import SwiftUI
import SpriteKit
import ARKit
import MapKit

struct ARView: View {
    @StateObject var arViewLocation: ARViewLocation
    var body: some View {
        ZStack{
            ARViewIndicator(region: self.arViewLocation.region)
                .ignoresSafeArea()
            
            HStack {
                Spacer()
                VStack{
                    MapButton(name: "xmark") {
                        withAnimation{
                            self.arViewLocation.showingARView.toggle()
                        }
                    }
                    .padding(.trailing)
                    
                    Spacer()
                }
            }
            
        }
    }
}

// MARK: - ARViewIndicator
struct ARViewIndicator: UIViewControllerRepresentable {
    var region: MKCoordinateRegion
    
    func makeUIViewController(context: Context) -> ARViewController {
        let arViewController = ARViewController()
        arViewController.region = self.region
        return arViewController
    }
    
    func updateUIViewController(_ uiViewController: ARViewController, context:
                                UIViewControllerRepresentableContext<ARViewIndicator>) {
        
    }
}

//struct ARView_Previews: PreviewProvider {
//    static var previews: some View {
//        ARView()
//    }
//}

class ARViewController: UIViewController, ARSKViewDelegate {
    var region: MKCoordinateRegion = MKCoordinateRegion()
    var sceneView: ARSKView = ARSKView()
    
    
    private func setSceneView() {
        self.sceneView.delegate = self
        //        self.sceneView.showsFPS = true
        //        self.sceneView.showsNodeCount = true
        self.sceneView.isUserInteractionEnabled = true
        self.sceneView.isMultipleTouchEnabled = true
        self.sceneView.isAsynchronous = true
        self.sceneView.shouldCullNonVisibleNodes = true
    }
    
    func categoryImageName(storyEntity: StoryEntity) -> String {
        let category = storyEntity.category
        var imageName = ""
        StoryMainCategory.allCases.forEach { mainCategory in
            let categoryArray = StoryCategory.inside(of: mainCategory).map {
                $0.rawValue
            }
            if categoryArray.contains(category) {
                imageName = mainCategory.rawValue
            }
        }
        return imageName
    }
    
    //    private func creatARAnchor(storyEntity: StoryEntity) -> ARAnchor {
    //        let entity = self.filterCategory()
    //        let node = SKSpriteNode()
    //        let imageName = self.categoryImageName(storyEntity: entity)
    //        node.texture = SKTexture(imageNamed: imageName)
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSceneView()
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.sceneView)
        self.sceneView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.sceneView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.sceneView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.sceneView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.sceneView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        
        // Load the SKScene from 'Scene.sks'
        if let scene = ARScene(fileNamed: "Scene") {
            scene.currentRegion = region.center
            self.sceneView.presentScene(scene)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        self.sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSKViewDelegate
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        let imageName = StoryMainCategory.allCases.map{ $0.rawValue }.randomElement() ?? ""
        let imageNode = SKSpriteNode(imageNamed: imageName)
        print(imageName)
        return imageNode
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
