//
//  MenuScene.swift
//  Championship Road
//
//  Created by Kaan Odabaş on 3.08.2023.
//
import SpriteKit
import AVFoundation

var playButton = SKSpriteNode()
var audioPlayer: AVAudioPlayer?

class MenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        playSound(name: "theme")
        playButton = SKSpriteNode(imageNamed: "play")
        playButton.position = CGPoint(x:-13, y:-101)
        playButton.size = CGSize(width: 570, height: 290)
        playButton.zPosition = 10
        playButton.name = "play"
        addChild(playButton)
        let scaleUp = SKAction.scale(to: 1.1, duration: 0.5)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.5)
        let pulsate = SKAction.sequence([scaleUp, scaleDown])
        let pulsateForever = SKAction.repeatForever(pulsate)
        playButton.run(pulsateForever)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node = atPoint(location)
            playSound(name: "theme")
            if node.name == "play" {
                // Play düğmesine dokunulduğunda, yeni oyun sahnesine geçiş yapalım
                transitionToGameScene()
            }
        }
    }
    
    // Oyun sahnesine geçiş yapmak için fonksiyon
    func transitionToGameScene() {
        if let view = self.view as? SKView {
            stopMusic()
            // GameScene dosyasından sahneyi oluşturun
            if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
                // Geçiş efektleri veya ek ayarlar yapabilirsiniz
                let transition = SKTransition.fade(withDuration: 1.5)
                
                // GameScene'i görüntüleyin
                scene.scaleMode = .aspectFill
                view.presentScene(scene, transition: transition)
            }
        }
    }
    
    func playSound(name: String) {
        let soundFileName = String(name) // Ses dosyanızın adını buraya yazın (uzantıyı dahil etmeyin)
        if let soundFilePath = Bundle.main.path(forResource: soundFileName, ofType: "mp3") { // Ses dosyasının yolunu bulun
            let soundFileURL = URL(fileURLWithPath: soundFilePath)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundFileURL) // AVAudioPlayer ile ses dosyasını yükleyin
                audioPlayer?.play()// Sesi çalın
            } catch {
                print("Ses dosyası yüklenemedi.")
                print(error.localizedDescription) // Print the error message for debugging
            }
        } else {
            print("Ses dosyası bulunamadı.")
        }
    }
    func stopMusic() {
            audioPlayer?.stop()
        }
}

