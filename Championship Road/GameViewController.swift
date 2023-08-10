//
//  GameViewController.swift
//  Championship Road
//
//  Created by Kaan Odabaş on 30.07.2023.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "MenuScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                
                // Present the scene
                view.presentScene(scene)
                
            }
            
        }
    }
    
    func transitionToGameScene() {
        if let view = self.view as! SKView? {
            // GameScene dosyasından sahneyi oluşturun
            if let scene = SKScene(fileNamed: "GameScene") {
                // Geçiş efektleri veya ek ayarlar yapabilirsiniz
                // Örneğin, crossFade(withDuration:) yöntemiyle yumuşak bir geçiş yapabilirsiniz.
                let transition = SKTransition.crossFade(withDuration: 2.5)
            
                // GameScene'i görüntüleyin
                scene.scaleMode = .aspectFill
                view.presentScene(scene, transition: transition)
    
            }
        }
    }
    
    func transitionToGameSceneLevel2() {
        if let view = self.view as! SKView? {
            // GameScene dosyasından sahneyi oluşturun
            if let Newscene = SKScene(fileNamed: "GameSceneLevel2") {
                // Geçiş efektleri veya ek ayarlar yapabilirsiniz
                // Örneğin, crossFade(withDuration:) yöntemiyle yumuşak bir geçiş yapabilirsiniz.
                let transition = SKTransition.crossFade(withDuration: 2.5)
            
                // GameScene'i görüntüleyin
                Newscene.scaleMode = .aspectFill
                view.presentScene(Newscene, transition: transition)
            }
        }
    }
    func transitionToGameSceneLevel3() {
        if let view = self.view as! SKView? {
            // GameScene dosyasından sahneyi oluşturun
            if let Newscene2 = SKScene(fileNamed: "GameSceneLevel3") {
                // Geçiş efektleri veya ek ayarlar yapabilirsiniz
                // Örneğin, crossFade(withDuration:) yöntemiyle yumuşak bir geçiş yapabilirsiniz.
                let transition = SKTransition.crossFade(withDuration: 2.5)
            
                // GameScene'i görüntüleyin
                Newscene2.scaleMode = .aspectFill
                view.presentScene(Newscene2, transition: transition)
            }
        }
    }
    func transitionToMenuScene() {
        if let view = self.view as? SKView {
            // GameScene dosyasından sahneyi oluşturun
            if let Newscene = SKScene(fileNamed: "MenuScene") as? MenuScene {
                // Geçiş efektleri veya ek ayarlar yapabilirsiniz
                let transition = SKTransition.fade(withDuration: 1.5)
                
                // GameScene'i görüntüleyin
                Newscene.scaleMode = .aspectFit
                view.presentScene(Newscene, transition: transition)
            }
        }
    }




    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
