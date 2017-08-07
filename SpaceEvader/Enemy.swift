
//
//  Enemy.swift
//  SpaceEvader
//
//  Created by Bohan Ma on 8/7/17.
//  Copyright © Bohan Ma. All rights reserved.
//

import Foundation
import SpriteKit

class Enemy: SKSpriteNode
    
{
    init(imageNamed: String)
    {
        let texture = SKTexture(imageNamed: "\(imageNamed)")
        super.init(texture: texture, color: UIColor(), size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addenemy ()
    {
        var bug : Enemy
        bug = Enemy (imageNamed: "Bugimage")
        
        bug.size.height = 35
        bug.size.width = 50
        
        let randomY = random() * ((size.height - bug.size.height/2)-bug.size.height/2) + bug.size.height/2
        
        bug.position = CGPoint(x: size.width = bug.size.width/2, y: randomY)
        addChild(bug)
        
        var moveBug: SKAction
        moveBug = SKAction.move(to: CGPoint(x: size.view + bug.size.view * 2, y: randomY), duration, (5.0))
        bug.run(moveBug)
        SKAction.removeFromParent
        
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addenemy), SKAction.wait(forDuration: 1.0)])))
        
    }
}
