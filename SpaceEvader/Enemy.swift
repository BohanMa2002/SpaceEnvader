
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

}
