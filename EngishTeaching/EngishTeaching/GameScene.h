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
#import "CharacterLines.h"
#import "BackgroundNode.h"

@interface GameScene : SKScene <SKPhysicsContactDelegate , DictionaryDelegate> {
    NPCGenerator *generator;
    NSMutableArray *generators;
    SKSpriteNode *darkerNode;
    BOOL isTalking;
    NPC *npcTalking;
}

@property SKLabelNode *textBox;
@property BackgroundNode *background;
@property SKSpriteNode *character;
@property GameViewController *viewController;

-(BOOL) moveCharacterTo:(UITouch*) touch andLocation:(CGPoint) location;

@end
