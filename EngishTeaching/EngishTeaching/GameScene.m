//
//  GameScene.m
//  Teste
//
//  Created by Danilo Mative on 09/04/15.
//  Copyright (c) 2015 FDJ. All rights reserved.
//

#import "GameScene.h"

@implementation SKScene (Unarchive)

+ (instancetype)unarchiveFromFile:(NSString *)file {
    /* Retrieve scene file path from the application bundle */
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    /* Unarchive the file to an SKScene object */
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];

    return scene;
}

@end

static const uint32_t characterCategory =  0x1 << 1;
static const uint32_t bodyCategory =  0x1 << 2;

@implementation GameScene{
    BOOL showDic;
    DictionaryScene *dicScene;
}

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    
    self.physicsWorld.contactDelegate = self;
    
    [self setBase:(SKSpriteNode*)[self childNodeWithName:@"fundo"]];
    [self setCharacter:(SKSpriteNode*)[self childNodeWithName:@"dark"]];
    
    SKPhysicsBody *cBody = [SKPhysicsBody bodyWithRectangleOfSize:[[self character] size]];
    
    cBody.collisionBitMask = characterCategory;
    cBody.contactTestBitMask = bodyCategory;

    
    [[self character] setPhysicsBody:cBody];
    
    
    for(int x = 0; x < [[[self base] children] count]; x++) {
        
        SKSpriteNode *node = [[[self base] children] objectAtIndex:x];
        
        SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:[node size]];
        
        body.collisionBitMask = bodyCategory;
        body.contactTestBitMask = characterCategory;

        body.pinned = true;
        
        body.dynamic = false;
        
        [node setPhysicsBody:body];
        [node setTexture:nil];
    }
    
    
    [[self character] setPosition:CGPointMake(self.size.width/2, self.size.height/2)];
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */

        //Checa se o dicionário está sendo mostrado na tela, caso verdadeiro, remove o dicionário da tela
    if (showDic) {
        showDic = false;
        [dicScene removeFromParent];
        return;
    }

    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInNode:self];

        //Checa se o botão do dicionário foi tocado, caso verdadeiro, mostra o dicionário na tela
    if ([[[self nodeAtPoint:[touch locationInNode:self]] name] isEqual:@"btnDictionary"]) {
        [self showDictionarySceneInAnswerMode:NO];
        return;
    }

    [[self character] runAction:[SKAction moveTo:CGPointMake(self.size.width/2, self.size.height/2) duration:0.1]];
    
    CGPoint fundoLocation = [touch locationInNode:self.base];
    
    if([[[self base] nodesAtPoint:fundoLocation] count] > 0) {
        return;
    }
    
    
    CGPoint position = CGPointMake(521, 400);
    CGPoint movePoint = CGPointMake(location.x - position.x , location.y - position.y);
    CGPoint basePosition = [[self base] position];
    
    
    basePosition.x -= movePoint.x;
    basePosition.y -= movePoint.y;

    double distance = sqrt((movePoint.x * movePoint.x) + (movePoint.y * movePoint.y));

    [[self base] runAction:[SKAction moveTo:basePosition duration:distance * 0.002]];
    
}

-(void)update:(CFTimeInterval)currentTime {

    /* Called before each frame is rendered */
    
    if([[self character] zRotation] != 0.0) {
        [[self character] runAction:[SKAction rotateToAngle:0.0 duration:0.1]];
    }
}

-(void)didBeginContact:(SKPhysicsContact *)contact{
    
    NSLog(@"Contact!");
    
    [[self base] removeAllActions];
    [[self character] runAction:[SKAction moveTo:CGPointMake(self.size.width/2, self.size.height/2) duration:0.1]];
}

/**
 Mostra cena do dicionário como filha da cena principal.
 
 @param isAnswer - Define se o dicionário será usado para definir uma resposta para um NPC ou se será somente consulta
 */
-(void) showDictionarySceneInAnswerMode:(BOOL)isAnswer{
    dicScene = [DictionaryScene unarchiveFromFile:@"DictionaryScene"];
    [dicScene startScene];
    [dicScene setSize:self.size];
    [dicScene setPhysicsBody:nil];
    [dicScene setAnswerMode:isAnswer];
    [dicScene setDictionaryDelegate:self];
    [self addChild:dicScene];
    showDic = true;
}

-(void)chosenWord:(Word *)word{

}

@end
