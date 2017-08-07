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
    
    let ball = SKSpriteNode(imageNamed: "xcodeicon.png")
    let ballSpeed: CGFloat = 100.0
    
    override func didMove(to view: SKView) {
    
    backgroundColor = SKColor.darkGray
    let xCord = size.width * 0.5
    let yCord = size.height * 0.5
        
    ball.size.height = 50
    ball.size.width = 50
        
    ball.position = CGPoint(x: xCord, y: yCord)
        
    addChild(ball)
    
    let swipeUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedUp))
    let swipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedDown))
    let swipeLeft: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedLeft))
    let swipeRight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedRight))
        
    swipeUp.direction = .up
    swipeDown.direction = .down
    swipeLeft.direction = .left
    swipeRight.direction = .right
    
        
    view.addGestureRecognizer(swipeUp)
    view.addGestureRecognizer(swipeDown)
    view.addGestureRecognizer(swipeLeft)
    view.addGestureRecognizer(swipeRight)

    }
    
    @objc func swipedUp(sender: UISwipeGestureRecognizer)
    {
        print ("swiped up")
        
        var actionMove: SKAction
        if (ball.position.y + ballSpeed >= size.height)
        {
            actionMove = SKAction.move(to: CGPoint(x : ball.position.x , y: size.height - ball.size.height / 2), duration: 0.5 )
        }
        else
        {
            actionMove = SKAction.move(to: CGPoint (x : ball.position.x , y: ball.position.y + ballSpeed), duration: 0.5)
        }
        ball.run(actionMove)
    }
    
    @objc func swipedDown(sender: UISwipeGestureRecognizer)
    {
        print("Swiped Down")
        
        var actionMove: SKAction
        if (ball.position.y - ballSpeed <= 0)
        {
            actionMove = SKAction.move(to: CGPoint(x : ball.position.x , y: ball.size.height / 2), duration: 0.5)
        }
        else
        {
            actionMove = SKAction.move(to: CGPoint (x: ball.position.x, y: ball.position.y - ballSpeed), duration: 0.5)
        }
        ball.run(actionMove)
    }
    
    @objc func swipedLeft(sender: UISwipeGestureRecognizer)
    {
        print("swiped Left")
        
        
        var actionMove: SKAction
        if (ball.position.x + ballSpeed <= size.height)
        {
            actionMove = SKAction.move(to: CGPoint(x: ball.size.width / 2 , y: ball.position.y), duration: 0.5)
        }
        else
        {
        actionMove = SKAction.move(to: CGPoint(x: ball.position.x - ballSpeed, y: ball.position.y), duration: 0.5)
        }
        ball.run(actionMove)
    }
    
    @objc func swipedRight(senter: UISwipeGestureRecognizer)
    {
        print("swiped Right")
        var actionMove: SKAction
        if (ball.position.x + ballSpeed >= size.width)
        {
            actionMove = SKAction.move(to: CGPoint(x: size.width - ball.size.width / 2 , y: ball.position.y ), duration: 0.5)
        }
        else
        {
        actionMove = SKAction.move(to: CGPoint(x: ball.position.x + ballSpeed, y: ball.position.y), duration: 0.5)
        }
        ball.run(actionMove)
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
        
        let bullet = SKSpriteNode(imageNamed: "ball.png")
        //bullet.color = UIColor.green
        bullet.size = CGSize (width: 20, height: 20)
        bullet.position = CGPoint (x: ball.position.x , y: ball.position.y)
        addChild(bullet)
        
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        let vector = CGVector(dx: -(ball.position.x - touchLocation.x), dy: -(ball.position.y - touchLocation.y))
        
        let projectileAction = SKAction.sequence([
            SKAction.repeat(SKAction.move(by: vector, duration: 0.5), count: 10),
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
