//
//  GameScene.swift
//  PushMe
//
//  Created by Training on 17/06/16.
//  Copyright (c) 2016 Training. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    
    var player:SKSpriteNode!
    var player2:SKSpriteNode!
    
    var initalPlayerPosition:CGPoint!
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let maximumPossibleForce = touch.maximumPossibleForce
            let force = touch.force
            let normalizedForce = force/maximumPossibleForce
            
            player.position.x = (self.size.width / 2) - normalizedForce * (self.size.width/2 - 25)
            player2.position.x = (self.size.width / 2) + normalizedForce * (self.size.width/2 - 25)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        resetPlayerPosition()
    }
    
    func resetPlayerPosition() {
        player.position = initalPlayerPosition
        player2.position = initalPlayerPosition
    }
    
    
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
        addPlayer()
        
    }
    
    func addRandomRow () {
        let randomNumber = Int(arc4random_uniform(6))
        
        addRow(RowType(rawValue: randomNumber)!)
    }
    
    var lastUpdateTimeInterval = NSTimeInterval()
    var lastYieldTimeInterval = NSTimeInterval()
    
    
    func updateWithTimeSinceLastUpdate (timeSinceLastUpdate:CFTimeInterval) {
        lastYieldTimeInterval += timeSinceLastUpdate
        if lastYieldTimeInterval > 0.6 {
            lastYieldTimeInterval = 0
            addRandomRow()
        }
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        
        var timeSinceLastUpdate = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        
        if timeSinceLastUpdate > 1 {
            timeSinceLastUpdate = 1/60
            lastUpdateTimeInterval = currentTime
        }
        
        updateWithTimeSinceLastUpdate(timeSinceLastUpdate)
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "PLAYER" {
            print("GAME OVER")
            showGameOver()
        }
    }
    
    func showGameOver () {
                
        let transition = SKTransition.fadeWithDuration(0.5)
        let gameOverScene = GameOverScene(size: self.size)
        self.view?.presentScene(gameOverScene, transition: transition)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
