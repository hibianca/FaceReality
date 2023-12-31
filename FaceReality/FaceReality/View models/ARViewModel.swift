//
//  ARViewModel.swift
//  FaceReality
//
//  Created by Bianca Nathally Bezerra de Lima on 06/09/23.
//

import Foundation
import RealityKit
import SwiftUI
import ARKit

class ARViewModel: UIViewController, ObservableObject, ARSessionDelegate {
    @Published private var model : ARModel = ARModel()
    @Published var emotions: Emotions = .Joy
    @Published var smileMuscles: SmileMuscles = SmileMuscles()
//    @Published var genuineSmileMuscles = GenuineSmileMuscles()
    @Published var sadnessMuscles: SadnessMuscles = SadnessMuscles()
    @Published var angerMuscles: AngerMuscles = AngerMuscles()
    @Published var surpriseMuscles: SurpriseMuscles = SurpriseMuscles()
    @Published var disgustMuscles: DisgustMuscles = DisgustMuscles()
    let neutralFeedback = String(localized: "neutral-string")

    func startSessionDelegate() {
        model.arView.session.delegate = self
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        if let faceAnchor = anchors.first as? ARFaceAnchor {
            model.update(faceAnchor: faceAnchor)
        }
    }
    
    var arView : ARView {
        model.arView
    }
    
    var isSmiling: Bool {
        var smileHelper = false
        if model.smileLeft > 0.3 || model.smileRight > 0.3 {
            smileHelper = true
        }
        return smileHelper
        
    }
    
    var genuineSmiling: Bool {
        var genSmileHelper = false
        if model.smileLeft > 0.3 && model.smileRight > 0.3 && model.squintLeft > 0.15 && model.squintRight > 0.15 {
            genSmileHelper = true
        }
        return genSmileHelper
    }
    
    var isScowling: Bool {
        var scowlHelper = false
        if model.sneerLeft > 0.17 && model.sneerRight > 0.17 && model.squintLeft > 0.05 && model.squintRight > 0.05 || model.shrugLower > 0.3 {

            scowlHelper = true
        }
        
        return scowlHelper
    }
    
    var isScared: Bool {
        var scaredHelper = false
        if model.wideLeft > 0.3 && model.wideRight > 0.3 {
            
            scaredHelper = true
        }
        
        return scaredHelper
    }
    var isDisgusted: Bool {
        var disgustedHelper = false
        if model.sneerLeft > 0.2 && model.sneerRight > 0.2 {
            
            disgustedHelper = true
        }
        
        return disgustedHelper
    }
    var isFrowning: Bool {
        var frownHelper = false
        if model.browInnerUp > 0.2 || model.mouthRollUpper > 0.2 || model.frownLeft > 0.2 || model.frownRight > 0.2 {
            
            frownHelper = true
        }
        
        return frownHelper
    }
    
    func smileChecker() -> String {
        let genuineSmilingFeedback = String(localized: "genuinesmile-string")
        let smilingFeedback = String(localized: "smiling-string")
        
        if self.isSmiling {
            if self.genuineSmiling {
                return genuineSmilingFeedback
            }
            else {
                return smilingFeedback
            }
        }
        else {
            return neutralFeedback
        }
    }
    
    func sadnessChecker() -> String {
        let sadnessFeedback = String(localized: "sadness-string")
        
        if self.isFrowning {
            return sadnessFeedback
        }
        else {
            return neutralFeedback
        }
    }
    
    func scowlChecker() -> String {
        let angerFeedback = String(localized: "anger-string")
        
        if self.isScowling {
            return angerFeedback
        }
        else {
            return neutralFeedback
            
        }
    }
    
    func surprisedChecker() -> String {
        let surpriseFeedback = String(localized: "surprise-string")
        
        if self.isScared {
            return surpriseFeedback
        }
        return neutralFeedback
        
    }
    
    func disgustChecker() -> String {
        let disgustedFeedback = String(localized: "disgusted-string")
        
        if self.isDisgusted {
            return disgustedFeedback
        }
        return neutralFeedback
    }
}
