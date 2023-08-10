//
//  MenuScene.swift
//  Championship Road
//
//  Created by Kaan Odabaş on 3.08.2023.
//

import Foundation
import SpriteKit

class MenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        // Ana menü ekranınızın arka planı
        let backgroundNode = SKSpriteNode(imageNamed: "backgroundImage")
        backgroundNode.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(backgroundNode)
        
        // "New Game" düğmesi
        let newGameButton = SKLabelNode(fontNamed: "Arial")
        newGameButton.text = "New Game"
        newGameButton.fontSize = 48
        newGameButton.position = CGPoint(x: frame.midX, y: frame.midY - 100)
        newGameButton.name = "newGameButton"
        addChild(newGameButton)
    }
    // Eğer gerekliyse tuş dokunma olaylarını (touchesBegan) ve geçişleri (transitions) burada tanımlayabilirsiniz.

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node = atPoint(location)
            
            // "New Game" düğmesine dokunulduğunda
            if node.name == "newGameButton" {
                let transition = SKTransition.fade(withDuration: 0.5)
                let gameScene = GameScene(size: size) // Yeni bir oyun sahnesi oluşturun
                gameScene.scaleMode = scaleMode
                view?.presentScene(gameScene, transition: transition)
            }
        }
    }

}
