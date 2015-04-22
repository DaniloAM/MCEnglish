//
//  GameScene.h
//  Teste
//

//  Copyright (c) 2015 FDJ. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "NPCGenerator.h"

@interface GameScene : SKScene <SKPhysicsContactDelegate> {
    NPCGenerator *generator;
}

@property SKSpriteNode *base;
@property SKSpriteNode *character;

@end
