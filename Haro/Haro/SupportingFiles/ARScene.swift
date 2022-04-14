//
//  Scene.swift
//  SwiftUISpriteKit
//
//  Created by Moon Jongseek on 2022/04/13.
//

import SpriteKit
import ARKit
import MapKit

class ARScene: SKScene {
    var filteredStoryEntitys: [StoryEntity]?
    private var selectedCategoryData: Data = UserDefaults.standard.data(forKey: "StoryCategory") ?? Data()
    var isSceneSetUp: Bool = false
    var currentRegion: CLLocationCoordinate2D?
    
    //    required init?(coder aDecoder: NSCoder) {
    //        super.init(coder: aDecoder)
    //        DispatchQueue.main.async {
    //            guard let sceneView = self.view as? ARSKView else {
    //                print("sceneView Error" )
    //                return
    //            }
    //
    //            self.filteredStoryEntitys = self.filterCategory()
    //            self.filteredStoryEntitys?.forEach { storyEntity in
    //                if storyEntity.category == "promenade" {
    //                    print(storyEntity.category)
    //
    //                    let calculateLatitude = Float(storyEntity.latitude - (self.currentRegion?.latitude ?? 0.0))
    //                    let calculateLongitude = Float(storyEntity.longitude - (self.currentRegion?.longitude ?? 0.0))
    //                    print(calculateLatitude,calculateLongitude)
    //
    //                    // Create anchor using the camera's current position
    //                    if let currentFrame = sceneView.session.currentFrame {
    //                        // Create a transform with a translation of 0.2 meters in front of the camera
    //                        var translation = matrix_identity_float4x4
    //
    //                        translation.columns.3.z = calculateLatitude
    //                        translation.columns.3.x = calculateLongitude
    //                        let transform = simd_mul(currentFrame.camera.transform, translation)
    //
    //                        // Add a new anchor to the session
    //                        print("")
    //                        let anchor = ARAnchor(transform: transform)
    //                        sceneView.session.add(anchor: anchor)
    //                    }
    //                }
    //            }
    //
    //            if let currentFrame = sceneView.session.currentFrame {
    //                // Create a transform with a translation of 0.2 meters in front of the camera
    //                var translation = matrix_identity_float4x4
    //
    //
    //                translation.columns.3.z = -0.5
    //                translation.columns.3.x = -0.5
    //                let transform = simd_mul(currentFrame.camera.transform, translation)
    //
    //                // Add a new anchor to the session
    //                let anchor = ARAnchor(transform: transform)
    //                sceneView.session.add(anchor: anchor)
    //            }
    //
    //        }
    //    }
    
    private func readJSON() -> Data? {
        do {
            if let bundlePath = Bundle.main.url(forResource: "StoryRawData", withExtension: "json") {
                let jsonData = try Data(contentsOf: bundlePath)
                return jsonData
            } else {
                return nil
            }
        } catch {
            print("JSON Read Error")
        }
        
        return nil
    }
    
    private func filterCategory() -> [StoryEntity] {
        if let jsonData = self.readJSON() {
            do {
                let selectedCategoryDictionary = try JSONDecoder().decode([String:Bool].self, from: self.selectedCategoryData)
                let mapPinsData = try JSONDecoder().decode([StoryEntity].self, from: jsonData)
                return mapPinsData.filter { storyEntity in
                    selectedCategoryDictionary[storyEntity.category] ?? false
                }
            } catch { return [] }
        } else { return [] }
    }
    
    func addAnchor(){
        guard let sceneView = self.view as? ARSKView else {
            return
        }
        
        // Create anchor using the camera's current position
        if let currentFrame = sceneView.session.currentFrame {
            // Create a transform with a translation of 0.2 meters in front of the camera
            var translation = matrix_identity_float4x4
            translation.columns.3.z = -1
            let transform = simd_mul(currentFrame.camera.transform, translation)
            
            // Add a new anchor to the session
            let anchor = ARAnchor(transform: transform)
            sceneView.session.add(anchor: anchor)
        }
    }
    
    override func sceneDidLoad() {
    }
    
    override func didMove(to view: SKView) {
        // Setup your scene here
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if !self.isSceneSetUp {
            guard let sceneView = self.view as? ARSKView else {
                print("sceneView Error" )
                return
            }
            
            self.filteredStoryEntitys = self.filterCategory()
            self.filteredStoryEntitys?.forEach { storyEntity in
                print(storyEntity.category)
                
                let calculateLatitude = Float(storyEntity.latitude - (self.currentRegion?.latitude ?? 0.0))
                let calculateLongitude = Float(storyEntity.longitude - (self.currentRegion?.longitude ?? 0.0))
                print(calculateLatitude,calculateLongitude)
                
                // Create anchor using the camera's current position
                if let currentFrame = sceneView.session.currentFrame {
                    // Create a transform with a translation of 0.2 meters in front of the camera
                    var translation = matrix_identity_float4x4
                    
                    translation.columns.3.z = calculateLatitude
                    translation.columns.3.x = calculateLongitude
                    let transform = simd_mul(currentFrame.camera.transform, translation)
                    
                    // Add a new anchor to the session
                    let anchor = ARAnchor(transform: transform)
                    sceneView.session.add(anchor: anchor)
                }
            }
        }
        self.isSceneSetUp = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.addAnchor()
    }
}
