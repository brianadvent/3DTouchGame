//
//  GameElements.swift
//  PushMe
//
//  Created by Training on 17/06/16.
//  Copyright © 2016 Training. All rights reserved.
//

import SpriteKit

struct CollisionBitMask {
    static let Player:UInt32 = 0x00
    static let Obstacle:UInt32 = 0x01
}

enum ObstacleType:Int {
    case Small = 0
    case Medium = 1
    case Large = 2
}

enum RowType:Int {
    case oneS = 0
    case oneM = 1
    case oneL = 2
    case twoS = 3
    case twoM = 4
    case threeS = 5
}


extension GameScene {
    
    func addPlayer() {
        player = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 50, height: 50))
        player.position = CGPoint(x: self.size.width / 2, y: 350)
        player.name = "PLAYER"
        player.physicsBody?.dynamic = false
        player.physicsBody = SKPhysicsBody(rectangleOfSize: player.size)
        player.physicsBody?.categoryBitMask = CollisionBitMask.Player
        player.physicsBody?.collisionBitMask = 0
        player.physicsBody?.contactTestBitMask = CollisionBitMask.Obstacle
        
        
        player2 = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 50, height: 50))
        player2.position = CGPoint(x: self.size.width / 2, y: 350)
        player2.name = "PLAYER"
        player2.physicsBody?.dynamic = false
        player2.physicsBody = SKPhysicsBody(rectangleOfSize: player2.size)
        player2.physicsBody?.categoryBitMask = CollisionBitMask.Player
        player2.physicsBody?.collisionBitMask = 0
        player2.physicsBody?.contactTestBitMask = CollisionBitMask.Obstacle
        
        addChild(player)
        addChild(player2)
        
        initalPlayerPosition = player.position
    
    }
    
    
    func addObstacle (type:ObstacleType) -> SKSpriteNode {
        let obstacle = SKSpriteNode(color: UIColor.whiteColor(), size: CGSize(width: 0, height: 30))
        obstacle.name = "OBSTACLE"
        obstacle.physicsBody?.dynamic = true
        
        switch type {
        case .Small:
            obstacle.size.width = self.size.width * 0.2
            break
        case .Medium:
            obstacle.size.width = self.size.width * 0.35
            break
        case .Large:
            obstacle.size.width = self.size.width * 0.75
            break
        
        }
        
        obstacle.position = CGPoint(x: 0, y: self.size.height + obstacle.size.height)
        obstacle.physicsBody = SKPhysicsBody(rectangleOfSize: obstacle.size)
        obstacle.physicsBody?.categoryBitMask = CollisionBitMask.Obstacle
        obstacle.physicsBody?.collisionBitMask = 0
        
        
        return obstacle
        
    }
    
    
    func addMovement (obstacle:SKSpriteNode) {
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.moveTo(CGPoint(x: obstacle.position.x, y: -obstacle.size.height), duration: NSTimeInterval(3)))
        actionArray.append(SKAction.removeFromParent())
        
        obstacle.runAction(SKAction.sequence(actionArray))
    }
    
    
    
    func addRow (type:RowType) {
        switch type {
        case .oneS:
            let obst = addObstacle(.Small)
            obst.position = CGPoint(x: self.size.width / 2, y: obst.position.y)
            addMovement(obst)
            addChild(obst)
            break
        case .oneM:
            let obst = addObstacle(.Medium)
            obst.position = CGPoint(x: self.size.width / 2, y: obst.position.y)
            addMovement(obst)
            addChild(obst)
            break
        case .oneL:
            let obst = addObstacle(.Large)
            obst.position = CGPoint(x: self.size.width / 2, y: obst.position.y)
            addMovement(obst)
            addChild(obst)
            break
        case .twoS:
            let obst1 = addObstacle(.Small)
            let obst2 = addObstacle(.Small)
            
            obst1.position = CGPoint(x: obst1.size.width + 50, y: obst1.position.y)
            obst2.position = CGPoint(x: self.size.width - obst2.size.width - 50, y: obst1.position.y)
            
            addMovement(obst1)
            addMovement(obst2)
            
            addChild(obst1)
            addChild(obst2)
            
            break
        case .twoM:
            let obst1 = addObstacle(.Medium)
            let obst2 = addObstacle(.Medium)
            
            obst1.position = CGPoint(x: obst1.size.width / 2 + 50, y: obst1.position.y)
            obst2.position = CGPoint(x: self.size.width - obst2.size.width / 2 - 50, y: obst1.position.y)
            
            addMovement(obst1)
            addMovement(obst2)
            
            addChild(obst1)
            addChild(obst2)
            
            break
        case .threeS:
            let obst1 = addObstacle(.Small)
            let obst2 = addObstacle(.Small)
            let obst3 = addObstacle(.Small)
            
            obst1.position = CGPoint(x: obst1.size.width / 2 + 50, y: obst1.position.y) // Left
            obst2.position = CGPoint(x: self.size.width - obst2.size.width / 2 - 50, y: obst1.position.y) // Right
            obst3.position = CGPoint(x: self.size.width / 2, y: obst1.position.y) // Center
            
            
            addMovement(obst1)
            addMovement(obst2)
            addMovement(obst3)
            
            addChild(obst1)
            addChild(obst2)
            addChild(obst3)
            
            break
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
