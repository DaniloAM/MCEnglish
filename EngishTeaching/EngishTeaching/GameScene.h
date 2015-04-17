//
//  GameScene.h
//  Teste
//

//  Copyright (c) 2015 FDJ. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DictionaryScene.h"

@interface GameScene : SKScene <SKPhysicsContactDelegate>

@property SKSpriteNode *base;
@property SKSpriteNode *character;

@end
