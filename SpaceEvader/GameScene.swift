//
//  GameScene.swift
//  SpaceEvader
//
//  Created by iD Student on 8/3/17.
//  Copyright © 2017 iD Tech. All rights reserved.
//

import SpriteKit
import GameplayKit



class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    let ball = SKSpriteNode(imageNamed: "ballIcon")
    
    override func didMove(to view: SKView) {
    
    backgroundColor = SKColor.darkGray
    let xCord = size.width * 0.5
    let yCord = size.height * 0.5
        
    ball.size.height = 50
    ball.size.width = 50
        
    ball.position = CGPoint(x: xCord, y: yCord)
        
    addChild(ball)
        
    
        
    let swipeUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedUp))
        
    swipeUp.direction = .up
        
    view.addGestureRecognizer(swipeUp)
    }
    
    func swipeUp(sender: UISwipeGestureRecognizer)
    {
        print ("swiped up")
    }
    
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        
        let bullet = SKSpriteNode()
        bullet.color = UIColor.green
        bullet.size = CGSize (width: 5, height: 5)
        bullet.position = CGPoint (x: ball.position.x , y: ball.position.y)
        addChild(bullet)
        
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        let vector = CGVector(dx: -(ball.position.x - touchLocation.x), dy: -(ball.position.y - touchLocation.y))
        
        let projectileAction = SKAction.squence
            ([
            SKAction.repeat(
            SKAction.move(by: vector, duration: 0.5), count: 10),
            SKAction.wait(forDuration: 0.5),
            SKAction.removeFromParent()
            ])
        bullet.run(projectileAction)
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
