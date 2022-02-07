//
//  GameScene.swift
//  Firework
//
//  Created by shenjie on 2022/2/7.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let colors = [UIColor.red, UIColor.green, UIColor.blue, UIColor.brown, UIColor.cyan, UIColor.orange]
    
    override func didMove(to view: SKView) {

        // 边界碰撞
        let screenBorder = SKPhysicsBody(edgeLoopFrom: self.frame)
        screenBorder.friction = 0 /// So doesn't slow down the objects that collide
        screenBorder.restitution = 1 /// So the ball bounces when hitting the screen borders
        screenBorder.categoryBitMask = 0
        screenBorder.collisionBitMask = 0
        screenBorder.contactTestBitMask = 0
        self.physicsBody = screenBorder
        
        // 定时器
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { time in
            self.fire()
        }
    }
    
    func fire(){
        // create particle
        let random = Int(arc4random_uniform(UInt32(self.colors.count)))
        let node: SKSpriteNode = generateNewSpriteNode(color: colors[random])
        let randomAngle = Int.random(in: -100...100)
        node.physicsBody?.applyImpulse(CGVector(dx: randomAngle, dy: 300))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }

    /// 生成新的节点
    /// - Parameters:
    ///   - color: 颜色
    /// - Returns: 是否成功
    func generateNewSpriteNode(color: UIColor) -> SKSpriteNode{
        let node = SKSpriteNode(color: color, size: CGSize(width: 30, height: 30))
        node.position = CGPoint(x: 0, y: -500)
        node.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        node.physicsBody?.isDynamic = true
        node.physicsBody?.restitution = 0
        
        let fire = SKEmitterNode(fileNamed: "Fire")
        fire?.targetNode = self
        fire?.particleColorBlendFactor = 1.0
        fire?.particleColorSequence = nil
        fire?.particleColor = color
        node.addChild(fire!)
        
        self.addChild(node)
        
        return node
    }

}
