//
//  GameScene.swift
//  Championship Road
//
//  Created by Kaan Odabaş on 30.07.2023.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //Characters
    var enemy1 = SKSpriteNode()
    var enemy3 = SKSpriteNode()
    var cup = SKSpriteNode()
    var tile2 = SKSpriteNode()
    var tile3 = SKSpriteNode()
    var ball = SKSpriteNode()
    var gameStarted = false
    var originalPosition  : CGPoint?
    var cupPosition2 : CGPoint?
    var audioPlayer: AVAudioPlayer?
    var enemy1Health: CGFloat = 100.0
    var enemy3Health: CGFloat = 100.0
    var spike1 = SKSpriteNode()
    var spike2 = SKSpriteNode()
    var spike3 = SKSpriteNode()
    var spike4 = SKSpriteNode()
    var spike5 = SKSpriteNode()
    var spike6 = SKSpriteNode()
    var spike7 = SKSpriteNode()
    var nextButton = SKSpriteNode()
    var gameWon = false
    var icardi = SKSpriteNode()


    //Healthbars
    var enemy1HealthBar: SKSpriteNode!
    var enemy3HealthBar: SKSpriteNode!
    let healthBarWidth: CGFloat = 50.0
    
    enum ColliderType : UInt32 {
        case Ball = 1
        case Enemy = 2
        case Cup = 4
        case Spike = 8
    }
    
    

    
    override func didMove(to view: SKView) {

        //ICARDI
        icardi = childNode(withName: "icardi") as! SKSpriteNode
        
        //TILES
        
        self.physicsWorld.contactDelegate = self
        
        tile2 = childNode(withName: "toprak2") as! SKSpriteNode
        let tile2Texture = SKTexture(imageNamed: "toprak2")
        let Tile2Size = CGSize(width: tile2Texture.size().width / 2.2, height: tile2Texture.size().height / 3.7)
        tile2.physicsBody = SKPhysicsBody(rectangleOf: Tile2Size)
        tile2.physicsBody?.affectedByGravity = false
        tile2.physicsBody?.isDynamic = false
        
        tile3 = childNode(withName: "toprak3") as! SKSpriteNode
        let tile3Texture = SKTexture(imageNamed: "toprak3")
        let newTile3Size = CGSize(width: tile3Texture.size().width / 3.2, height: tile3Texture.size().height / 3.9)
        tile3.physicsBody = SKPhysicsBody(rectangleOf: newTile3Size)
        tile3.physicsBody?.affectedByGravity = false
        tile3.physicsBody?.isDynamic = false
        
        //SPIKES
        
        spike1 = childNode(withName: "spike1") as! SKSpriteNode
        let spikeTexture = SKTexture(imageNamed: "spike1")
        let spikeSize = CGSize(width: spikeTexture.size().width * 1.45, height: spikeTexture.size().height / 3)
        spike1.physicsBody = SKPhysicsBody(rectangleOf: spikeSize)
        spike1.physicsBody?.affectedByGravity = false
        spike1.physicsBody?.isDynamic = false
        spike1.physicsBody?.collisionBitMask = ColliderType.Ball.rawValue
        
        spike2 = childNode(withName: "spike2") as! SKSpriteNode
        spike2.physicsBody = SKPhysicsBody(rectangleOf: spikeSize)
        spike2.physicsBody?.affectedByGravity = false
        spike2.physicsBody?.isDynamic = false
        spike2.physicsBody?.collisionBitMask = ColliderType.Ball.rawValue
        
        spike3 = childNode(withName: "spike3") as! SKSpriteNode
        spike3.physicsBody = SKPhysicsBody(rectangleOf: spikeSize)
        spike3.physicsBody?.affectedByGravity = false
        spike3.physicsBody?.isDynamic = false
        spike3.physicsBody?.collisionBitMask = ColliderType.Ball.rawValue
        
        spike4 = childNode(withName: "spike4") as! SKSpriteNode
        spike4.physicsBody = SKPhysicsBody(rectangleOf: spikeSize)
        spike4.physicsBody?.affectedByGravity = false
        spike4.physicsBody?.isDynamic = false
        spike4.physicsBody?.collisionBitMask = ColliderType.Ball.rawValue
        
        spike5 = childNode(withName: "spike5") as! SKSpriteNode
        spike5.physicsBody = SKPhysicsBody(rectangleOf: spikeSize)
        spike5.physicsBody?.affectedByGravity = false
        spike5.physicsBody?.isDynamic = false
        spike5.physicsBody?.collisionBitMask = ColliderType.Ball.rawValue
        
        spike6 = childNode(withName: "spike6") as! SKSpriteNode
        spike6.physicsBody = SKPhysicsBody(rectangleOf: spikeSize)
        spike6.physicsBody?.affectedByGravity = false
        spike6.physicsBody?.isDynamic = false
        spike6.physicsBody?.collisionBitMask = ColliderType.Ball.rawValue
        
        spike7 = childNode(withName: "spike7") as! SKSpriteNode
        spike7.physicsBody = SKPhysicsBody(rectangleOf: spikeSize)
        spike7.physicsBody?.affectedByGravity = false
        spike7.physicsBody?.isDynamic = false
        spike7.physicsBody?.collisionBitMask = ColliderType.Ball.rawValue
        
        
        
        
        //CUP
        cup = childNode(withName: "cup") as! SKSpriteNode
        let cupTexture = SKTexture(imageNamed: "cup")
        let cupSize = CGSize(width: cupTexture.size().width/5.5, height: cupTexture.size().height/5.5)
        cup.physicsBody = SKPhysicsBody(rectangleOf: cupSize)
        cup.physicsBody?.isDynamic = true
        cup.physicsBody?.mass = 0.065
        cup.physicsBody?.allowsRotation = false
        cupPosition2 = cup.position
        
        cup.physicsBody?.collisionBitMask = ColliderType.Ball.rawValue
        
        //BALL
        ball = childNode(withName: "ball") as! SKSpriteNode
        let ballTexture = SKTexture(imageNamed: "ball")
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ballTexture.size().height/3.15)
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.mass = 0.065
        originalPosition = ball.position
        
        ball.physicsBody?.contactTestBitMask = ColliderType.Ball.rawValue
        ball.physicsBody?.categoryBitMask = ColliderType.Ball.rawValue
        ball.physicsBody?.collisionBitMask = ColliderType.Enemy.rawValue
        ball.physicsBody?.collisionBitMask = ColliderType.Cup.rawValue
        ball.physicsBody?.collisionBitMask = ColliderType.Spike.rawValue

        
        
        //Enemies
        let enemyTexture = SKTexture(imageNamed: "enemy")
        let size = CGSize(width: enemyTexture.size().width / 5.2 , height: enemyTexture.size().height / 5.2)
        
        enemy1 = childNode(withName: "enemy1") as! SKSpriteNode
        enemy1.physicsBody = SKPhysicsBody(circleOfRadius: enemyTexture.size().height/5.2)
        enemy1.physicsBody?.isDynamic = false
        enemy1.physicsBody?.affectedByGravity = false
        enemy1.physicsBody?.allowsRotation = false
        enemy1.physicsBody?.mass = 0.15
        enemy1.physicsBody?.collisionBitMask = ColliderType.Ball.rawValue
        
        
        enemy3 = childNode(withName: "enemy3") as! SKSpriteNode
        enemy3.physicsBody = SKPhysicsBody(circleOfRadius: enemyTexture.size().height/5.2)
        enemy3.physicsBody?.isDynamic = false
        enemy3.physicsBody?.affectedByGravity = false
        enemy3.physicsBody?.allowsRotation = false
        enemy3.physicsBody?.mass = 0.15
        enemy3.physicsBody?.collisionBitMask = ColliderType.Ball.rawValue
        
        //Healthbar
        let healthBarWidth: CGFloat = 50.0
        let healthBarHeight: CGFloat = 5.0
        
        enemy1HealthBar = SKSpriteNode(color: .green, size: CGSize(width: healthBarWidth, height: healthBarHeight))
        enemy1HealthBar.anchorPoint = CGPoint(x: 0.0, y: 0.5)
        enemy1HealthBar.position = CGPoint(x: enemy1.position.x - healthBarWidth / 2, y: enemy1.position.y + enemy1.size.height / 2 + 10)
        self.addChild(enemy1HealthBar)

        enemy3HealthBar = SKSpriteNode(color: .green, size: CGSize(width: healthBarWidth, height: healthBarHeight))
        enemy3HealthBar.anchorPoint = CGPoint(x: 0.0, y: 0.5)
        enemy3HealthBar.position = CGPoint(x: enemy3.position.x - healthBarWidth / 2, y: enemy3.position.y + enemy3.size.height / 2 + 10)
        self.addChild(enemy3HealthBar)
        
        //GameScene Physics
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.scene?.scaleMode = .aspectFit
        self.physicsWorld.contactDelegate = self
        
        //NextButton
        nextButton = SKSpriteNode(imageNamed: "next")
        nextButton.position = CGPoint(x:0, y:-70)
        nextButton.size = CGSize(width: 260, height: 115)
        nextButton.zPosition = 10
        addChild(nextButton)
        let scaleUp = SKAction.scale(to: 1.1, duration: 0.5)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.5)
        let pulsate = SKAction.sequence([scaleUp, scaleDown])
        let pulsateForever = SKAction.repeatForever(pulsate)
        nextButton.run(pulsateForever)
        
        //Apply MoveEnemis func.
        moveEnemies()
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.collisionBitMask == ColliderType.Ball.rawValue || contact.bodyB.collisionBitMask == ColliderType.Ball.rawValue {
            
            if contact.bodyA.node == enemy1 || contact.bodyB.node == enemy1 {
                playSound(name: "bee")
                applyDamageToEnemy(enemy: enemy1, damage: 20.0)
                if enemy1Health == 0 {
                    enemy1.isHidden = true
            
                }
            }
            
            if contact.bodyA.node == enemy3 || contact.bodyB.node == enemy3 {
                playSound(name: "bee")
                applyDamageToEnemy(enemy: enemy3, damage: 20.0)
                if enemy3Health == 0 {
                    enemy3.isHidden = true
                }
            }
            if contact.bodyA.node == cup || contact.bodyB.node == cup {
                if enemy1Health == 0 && enemy3Health == 0 {
                    playSound(name: "aşkınolayım")
                    let win = SKLabelNode(text: "Level Passed!")
                    win.fontName = "Helvatica"
                    win.fontSize = 100
                    win.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
                    win.zPosition = 10
                    self.addChild(win)
                    animateBallToIcardi()
                    gameWon = true
                    
                    
                    

                }
                else {
                    cup.position = cupPosition2!
                    print("hata")
                    showTryAgainMessage()
                    resetGame()
                    enemy3.isHidden = false
                    enemy1.isHidden = false
                }
            }

        
            }
            
            
        }

    
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    /*  bird.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 100))
        bird.physicsBody?.affectedByGravity = true
    */
       
        if gameStarted == false {
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                let touchedNode = atPoint(touchLocation)
                if touchedNode == nextButton {
                        let scaleAction = SKAction.sequence([
                            SKAction.scale(to: 1.2, duration: 0.1),
                            SKAction.scale(to: 1.0, duration: 0.1),
                            SKAction.run { [weak self] in
                                self?.transitionToGameSceneLevel2()
                            }
                        ])
                        nextButton.run(scaleAction)
                        transitionToGameSceneLevel2()
                    } else {
                        // Diğer dokunma işlemleri
                    }
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == ball {
                                ball.position = touchLocation
                                cup.position = cupPosition2!
                                if enemy1Health == 0 {
                                    enemy1.isHidden = true
                                    enemy1.physicsBody?.categoryBitMask = 0 // Remove from all collision categories
                                    enemy1.physicsBody?.collisionBitMask = 0 // Remove from all collision categories
                                    enemy1.physicsBody?.contactTestBitMask = 0
                                }
                                if enemy3Health == 0 {
                                    enemy3.physicsBody?.categoryBitMask = 0 // Remove from all collision categories
                                    enemy3.physicsBody?.collisionBitMask = 0 // Remove from all collision categories
                                    enemy3.physicsBody?.contactTestBitMask = 0
                                }
                            }
                        }
                            
                    }
                }
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted == false {
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == ball {
                                ball.position = touchLocation
                            }
                        }
                            
                    }
                }
            }
        }

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted == false {
            for node in self.children {
                if let label = node as? SKLabelNode, label.text == "Try Again" {
                    label.removeFromParent()
                }
                
                gameStarted = true
               
            }
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == ball {
                                let dx = -(touchLocation.x - originalPosition!.x)
                                let dy = -(touchLocation.y - originalPosition!.y)
                                let impulse = CGVector(dx: dx, dy: dy)
                                ball.physicsBody?.applyImpulse(impulse)
                                ball.physicsBody?.affectedByGravity = true
                                   
                                gameStarted = true
                            }
                        }
                            
                    }
                }
            }
        }

    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        if gameWon {
            nextButton.isHidden = false
        } else {
            nextButton.isHidden = true
        }
        
        if let ballPhysicsBody = ball.physicsBody {
            if ballPhysicsBody.velocity.dx <= 0.002 && ballPhysicsBody.velocity.dy <= 0.002 && ballPhysicsBody.angularVelocity <= 0.06 && gameStarted == true {
                
                ball.physicsBody?.affectedByGravity = false
                ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                ball.physicsBody?.angularVelocity = 0
                ball.zPosition = 5
                ball.position = originalPosition!
                gameStarted = false
                
            }
            
            
        
        }
        
    }
    
    func moveEnemies() {
        let moveRightAction = SKAction.moveBy(x: 150, y: 0, duration: 1.5) // Sağa hareket
        let moveLeftAction = SKAction.moveBy(x: -150, y: 0, duration: 1.5) // Sola hareket
        let moveUpAction = SKAction.moveBy(x: 0, y: 50, duration: 0.3) // Yukarı hareket
        let moveDownAction = SKAction.moveBy(x: 0, y: -50, duration: 0.6) //Aşağı hareket


        // Düşmanları sağa ve sola hareket ettirme işlemleri
        let moveRightSequence = SKAction.sequence([moveRightAction, SKAction.wait(forDuration: 0.6), moveLeftAction,moveDownAction,moveUpAction])

        // Düşmanlara hareket eylemlerini sürekli tekrar etme
        enemy1.run(SKAction.repeatForever(moveRightSequence))
        enemy3.run(SKAction.repeatForever(moveRightSequence))
        
        
        enemy1HealthBar.run(SKAction.repeatForever(moveRightSequence))
        enemy3HealthBar.run(SKAction.repeatForever(moveRightSequence))



    }
 
    func playSound(name: String) {
        let soundFileName = String(name) // Ses dosyanızın adını buraya yazın (uzantıyı dahil etmeyin)
        if let soundFilePath = Bundle.main.path(forResource: soundFileName, ofType: "mp3") { // Ses dosyasının yolunu bulun
            let soundFileURL = URL(fileURLWithPath: soundFilePath)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundFileURL) // AVAudioPlayer ile ses dosyasını yükleyin
                audioPlayer?.play() // Sesi çalın
            } catch {
                print("Ses dosyası yüklenemedi.")
                print(error.localizedDescription) // Print the error message for debugging
            }
        } else {
            print("Ses dosyası bulunamadı.")
        }
    }


    //HEALTH BAR
    func applyDamageToEnemy(enemy: SKSpriteNode, damage: CGFloat) {
        var healthBar: SKSpriteNode
        var currentHealth: CGFloat
        
        if enemy == enemy1 {
            enemy1Health -= damage
            if enemy1Health < 0 {
                
            }
            healthBar = enemy1HealthBar
            currentHealth = enemy1Health
        } else if enemy == enemy3 {
            enemy3Health -= damage
            if enemy3Health < 0 {
                
            }
            healthBar = enemy3HealthBar
            currentHealth = enemy3Health
        } else {
            return
        }
        
        updateHealthBar(healthBar: healthBar, currentHealth: currentHealth)
        
        if currentHealth == 0 {
            // Düşman öldü, burada gerekli işlemleri yapabilirsiniz
            // Düşmanı sahneden kaldırın
            // Gerekli diğer işlemleri yapabilirsiniz
        }
    }


    
    //HEALTH BAR
    func updateHealthBar(healthBar: SKSpriteNode, currentHealth: CGFloat) {
        let healthPercentage = currentHealth / 100.0
        healthBar.size.width = healthBarWidth * healthPercentage
        }
    
    func showTryAgainMessage() {
        // You can display a message to the user here, for example, by adding a label or node to the scene.
        let tryAgainLabel = SKLabelNode(text: "Try Again")
        tryAgainLabel.fontName = "Helvatica"
        tryAgainLabel.fontSize = 100
        tryAgainLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        tryAgainLabel.zPosition = 10
        self.addChild(tryAgainLabel)
        
        gameStarted = true
        }
    func resetGame() {
        
        enemy1Health = 100.0
        enemy3Health = 100.0
        updateHealthBar(healthBar: enemy1HealthBar, currentHealth: enemy1Health)
        updateHealthBar(healthBar: enemy3HealthBar, currentHealth: enemy3Health)
        enemy1.isHidden = false
        enemy3.isHidden = false
        
            
        // Topun başlangıç konumuna getirilmesi
        ball.position = originalPosition!
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        ball.physicsBody?.angularVelocity = 0
        ball.physicsBody?.affectedByGravity = false
        cup.position = cupPosition2!
        
        enemy1.physicsBody?.categoryBitMask = ColliderType.Enemy.rawValue
        enemy1.physicsBody?.collisionBitMask = ColliderType.Ball.rawValue
        enemy1.physicsBody?.contactTestBitMask = ColliderType.Ball.rawValue
        
        enemy3.physicsBody?.categoryBitMask = ColliderType.Enemy.rawValue
        enemy3.physicsBody?.collisionBitMask = ColliderType.Ball.rawValue
        enemy3.physicsBody?.contactTestBitMask = ColliderType.Ball.rawValue
        
        gameStarted = false
            
        }
    
    func didEnd(_ contact: SKPhysicsContact) {
        // Eğer top spikelara çarparsa, çarpışma sonlandığında topun başlangıç pozisyonuna dönmesini sağlayalım.
        let collisionMask = contact.bodyA.collisionBitMask | contact.bodyB.collisionBitMask
        if collisionMask == (ColliderType.Ball.rawValue | ColliderType.Spike.rawValue) {
            ball.position = originalPosition!
            ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            ball.physicsBody?.angularVelocity = 0
            ball.physicsBody?.affectedByGravity = false
        }
       }
    func animateBallToIcardi() {
        let moveAction = SKAction.move(to: cup.position, duration: 4.0)
        icardi.run(moveAction) {
            // Top icardi karakterine ulaştı, gerektiğinde ekstra işlemler yapabilirsiniz
            // İcardi karakterine odaklanmak için kamerayı hedef pozisyona taşıyalım
            let moveCameraAction = SKAction.move(to: self.icardi.position, duration: 8.0)
            self.camera?.run(moveCameraAction)
        }
    }

    func transitionToGameSceneLevel2() {
        if let view = self.view as? SKView {
            stopMusic()
            // GameScene dosyasından sahneyi oluşturun
            if let Newscene = SKScene(fileNamed: "GameSceneLevel2") as? GameSceneLevel2 {
                // Geçiş efektleri veya ek ayarlar yapabilirsiniz
                let transition = SKTransition.fade(withDuration: 1.5)
                
                // GameScene'i görüntüleyin
                Newscene.scaleMode = .aspectFill
                view.presentScene(Newscene, transition: transition)
            }
        }
    }
    func stopMusic() {
            audioPlayer?.stop()
        }
    
}


