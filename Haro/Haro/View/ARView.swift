//
//  ARView.swift
//  Haro
//
//  Created by Moon Jongseek on 2022/04/13.
//

import SwiftUI
import SpriteKit
import ARKit

struct ARView: View {
    @Binding var showingARView: Bool
    
    var body: some View {
        ZStack{
            ARViewIndicator()
                .ignoresSafeArea()
            
            HStack {
                Spacer()
                VStack{
                    MapButton(name: "xmark") {
                        withAnimation{
                            self.showingARView.toggle()
                        }
                    }
                    //                    Button {
                    //                        withAnimation{
                    //                            self.showingARView.toggle()
                    //                        }
                    //                    } label: {
                    //                        ZStack {
                    //                            RoundedRectangle(cornerRadius: 15, .circular)
                    //                                .fill(.white.opacity(0.6))
                    //                            Image(systemName: "xmark")
                    //                                .font(.title)
                    //                                .foregroundColor(.black)
                    //                        }
                    //                    }
                    //                    .frame(width: 60, height: 60)
                    .padding(.trailing)
                    
                    Spacer()
                }
            }
            
        }
    }
}

// MARK: - ARViewIndicator
struct ARViewIndicator: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ARViewController {
        return ARViewController()
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
    
    var sceneView: ARSKView = ARSKView()
    
    private func setSceneView() {
        self.sceneView.delegate = self
        self.sceneView.showsFPS = true
        self.sceneView.showsNodeCount = true
        self.sceneView.isUserInteractionEnabled = true
        self.sceneView.isMultipleTouchEnabled = true
        self.sceneView.isAsynchronous = true
        self.sceneView.shouldCullNonVisibleNodes = true
    }
    
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
        if let scene = SKScene(fileNamed: "Scene") {
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
        // Create and configure a node for the anchor added to the view's session.
        let labelNode = SKLabelNode(text: ["👾","🍎","📱","🤔","☀️"].randomElement())
        labelNode.horizontalAlignmentMode = .center
        labelNode.verticalAlignmentMode = .center
        return labelNode;
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
