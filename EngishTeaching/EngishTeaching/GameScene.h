//
//  GameScene.h
//  Teste
//

//  Copyright (c) 2015 FDJ. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "NPCGenerator.h"
#import "DictionaryScene.h"
#import "GameViewController.h"

@interface GameScene : SKScene <SKPhysicsContactDelegate , DictionaryDelegate> {
    NPCGenerator *generator;
}


@property SKSpriteNode *base;
@property SKSpriteNode *character;
@property GameViewController *viewController;

-(BOOL) moveCharacterTo:(UITouch*) touch andLocation:(CGPoint) location;

@end
