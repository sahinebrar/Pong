//
//  GameScene.swift
//  Pong
//
//  Created by Ebrar Sahin on 24.08.2017.
//  Copyright © 2017 Ebrar Sahin. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    var mainScoreLabel = SKLabelNode()
    var enemyScoreLabel = SKLabelNode()
    var score = [Int]()
    
    
    
    override func didMove(to view: SKView) {
        
        startGame()
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        enemy.position.y = (self.frame.height/2) - 50
        
        main = self.childNode(withName: "main") as! SKSpriteNode
        main.position.y = (-self.frame.height/2) + 50
        
        mainScoreLabel = self.childNode(withName: "mainScoreLabel") as! SKLabelNode
        enemyScoreLabel = self.childNode(withName: "enemyScoreLabel") as! SKLabelNode
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        
    }

    func startGame(){
        score = [0, 0]
    }
    
    func addScore(playerWhoWon: SKSpriteNode){
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == main {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        }
        else if playerWhoWon == enemy {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            main.run(SKAction.moveTo(x: location.x, duration: 0.1))
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            main.run(SKAction.moveTo(x: location.x, duration: 0.1))
            
        }
    }

    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.5))
        
        if ball.position.y <= main.position.y - 30{
            addScore(playerWhoWon: enemy)
        }
        else if ball.position.y >= enemy.position.y + 30{
            addScore(playerWhoWon: main)
        }
        mainScoreLabel.text = String(score[0])
        enemyScoreLabel.text = String(score[1])
        
        print(score)
    }
}
