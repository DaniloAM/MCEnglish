//
//  GameScene.m
//  Teste
//
//  Created by Danilo Mative on 09/04/15.
//  Copyright (c) 2015 FDJ. All rights reserved.
//

#import "GameScene.h"
#import "GameViewController.h"

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
    
    [self setTextBox:(SKLabelNode*)[self childNodeWithName:@"textBox"]];
    [[self textBox] setZPosition:10.0];
    [[self textBox] setHidden:true];
    [self setBackground:(BackgroundNode*)[self childNodeWithName:@"fundo"]];
    
    SKSpriteNode *back = (SKSpriteNode *)[self childNodeWithName:@"fundo"];
    _background = [[BackgroundNode alloc] initWithTexture:back.texture];
    
    _background.size = back.size;
    _background.position = back.position;
    
    for(SKNode *node in back.children) {
        [node removeFromParent];
        [_background addChild:node];
    }
    
    [back removeFromParent];
    [self addChild:_background];
    
    [self setCharacter:(SKSpriteNode*)[self childNodeWithName:@"character"]];
    
    SKPhysicsBody *cBody = [SKPhysicsBody bodyWithRectangleOfSize:[[self character] size]];
    
    cBody.collisionBitMask = characterCategory;
    cBody.contactTestBitMask = bodyCategory;

    
    [[self character] setPhysicsBody:cBody];
    
    
    for(int x = 0; x < [[[self background] children] count]; x++) {
        
        SKSpriteNode *node = [[[self background] children] objectAtIndex:x];
        
        SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:[node size]];
        
        body.collisionBitMask = bodyCategory;
        body.contactTestBitMask = characterCategory;

        body.pinned = true;
        
        body.dynamic = false;
        
        [node setPhysicsBody:body];
        [node setTexture:nil];
    }
    
    
    [[self character] setPosition:CGPointMake(self.size.width/2, self.size.height/2)];
    
    
    //GENERATION TEST *********************

    
    generator = [[NPCGenerator alloc] initWithGenerationType:GTCityType spawnRate:1.0 inPosition:CGPointMake(-250, -227) atNode:[self background]];
    
    NPCFile *file1 = [[NPCFile alloc] initWithTextureName:@"LightCharacter.png" andPictureName:@"LightCharacter.png" withGender:1];
    
    NPCFile *file2 = [[NPCFile alloc] initWithTextureName:@"DarkCharacter.png" andPictureName:@"DarkCharacter.png" withGender:0];
    
    [generator addNPCFiles:@[file1, file2]];
    
    [generator startGeneratingNPC];
    
    
    //Darker node
    darkerNode = [[SKSpriteNode alloc] initWithColor:[UIColor blackColor] size:self.size];
    
    darkerNode.zPosition = 5.0;
    
    darkerNode.alpha = 0.0;
    
    darkerNode.position = CGPointMake(self.size.width/2, self.size.height/2);
    
    [self addChild:darkerNode];
    
    [_textBox setFontColor:[UIColor whiteColor]];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
#warning Teste para a cena do restaurante, apagar depois
//    [self.viewController showScene:@"RestaurantScene"];
    /* Called when a touch begins */

        //Checa se o dicionário está sendo mostrado na tela, caso verdadeiro, remove o dicionário da tela
    
    if(isTalking) {
        [self endNPCTalking];
        return;
    }
    
    if (showDic) {
        showDic = false;
        [dicScene removeFromParent];
        return;
    }

    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInNode:self];

    if ([self checkIfDictionaryWasTouched:touch inLocation:location]) {
        return;
    }

    if (![self moveCharacterTo:touch andLocation:location]) {
        return;
    }
}

-(void)update:(CFTimeInterval)currentTime {

    /* Called before each frame is rendered */
    
    if([[self character] zRotation] != 0.0) {
        [[self character] runAction:[SKAction rotateToAngle:0.0 duration:0.1]];
    }
}

-(void)didBeginContact:(SKPhysicsContact *)contact{

    SKNode *nodeA = [[contact bodyA] node];
    SKNode *nodeB = [[contact bodyB] node];
    
    NSString *nameA = [[[contact bodyA] node] name];
    NSString *nameB = [[[contact bodyB] node] name];
    
    if([nameA isEqualToString:@"npc"]) {
        
        
        if([nameB isEqualToString:@"character"]) {
            //TALK ACTION
            //***********
            [nodeA removeAllActions];
            [nodeB removeAllActions];
            
            NPC *npc = (NPC *)nodeA;
            
            [self startNPCTalking:npc];
        }
        
        else [[[contact bodyA] node] removeFromParent];
        
        return;
    }
    
    else if([nameB isEqualToString:@"npc"]) {
        
        
        if([nameA isEqualToString:@"character"]) {
            //TALK ACTION
            //***********
            [nodeA removeAllActions];
            [nodeB removeAllActions];
            
            NPC *npc = (NPC *)nodeB;
            
            [self startNPCTalking:npc];
        }
        
        else [[[contact bodyB] node] removeFromParent];
        
        return;
    }
    
    
    [[self background] removeAllActions];
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

/**
 Verifica se o botão do dicionário foi tocado
 
 @param touch - toque na tela
 @param location - posição do toque na tela
 
 @return verdadeiro se o botão foi tocado, falso caso contrário
 */
-(BOOL) checkIfDictionaryWasTouched:(UITouch*) touch inLocation:(CGPoint) location{
        //Checa se o botão do dicionário foi tocado, caso verdadeiro, mostra o dicionário na tela
    if ([[[self nodeAtPoint:[touch locationInNode:self]] name] isEqual:@"btnDictionary"]) {
        [self showDictionarySceneInAnswerMode:NO];
        return true;
    }
    return false;
}

/**
 Move o personagem para a posição do toque
 
 @param touch - toque na tela
 @param location - posição do toque na tela

 @return verdadeiro se foi possível mover o personagem, falso caso contrário
 */
-(BOOL) moveCharacterTo:(UITouch*) touch andLocation:(CGPoint) location{
    [[self character] runAction:[SKAction moveTo:CGPointMake(self.size.width/2, self.size.height/2) duration:0.1]];

    CGPoint fundoLocation = [touch locationInNode:self.background];
    
    if([[[self background] nodesAtPoint:fundoLocation] count] > 0) {

        BOOL notMove = true;
        
        for(SKNode *node in [[self background] nodesAtPoint:fundoLocation]) {
            
            if([node.name isEqualToString:@"npc"]) {
                notMove = false;
                
                NPC *npc = (NPC *)node;
                
                [self startNPCTalking:npc];
            }
        }
        
        if(notMove) {
            return false;
        }
    }
    
    CGPoint position = CGPointMake(521, 400);
    CGPoint movePoint = CGPointMake(location.x - position.x , location.y - position.y);
    CGPoint backgroundPosition = [[self background] position];

    backgroundPosition.x -= movePoint.x;
    backgroundPosition.y -= movePoint.y;

    double distance = sqrt((movePoint.x * movePoint.x) + (movePoint.y * movePoint.y));

    [[self background] runAction:[SKAction moveTo:backgroundPosition duration:distance * 0.002]];
    return true;
}


-(void)startNPCTalking: (NPC*)npc {
    
    isTalking = true;

    _textBox.text = [[npc chain] line];
    [[self textBox] setHidden:false];
    
    [self darkerScene];
    [self pauseAllNPCs];
    
    //[self showDictionarySceneInAnswerMode:true];
}

-(void)endNPCTalking {
    
    isTalking = false;
    
    _textBox.hidden = true;
    
    [self lighterScene];
    [self unpauseAllNPCs];
    
}

-(void)darkerScene {
    
    [darkerNode runAction:[SKAction fadeAlphaBy:0.6 duration:0.2]];
    
}

-(void)lighterScene {
    
    [darkerNode runAction:[SKAction fadeAlphaTo:0.0 duration:0.2]];
    
}

-(void)pauseAllNPCs {
    
    [generator stopGenerating];
    
    for(SKNode *npc in _background.npcArray) {
        [npc removeAllActions];
    }
    
}

-(void)unpauseAllNPCs {
    
    [generator startGeneratingNPC];
    
    for(int x = 0; x < _background.npcArray.count; x++) {
        NPC *npc = (NPC *)[_background.npcArray objectAtIndex:x];
        
        if(![npc hasActions])
            [npc runAction:[npc actionDireciton]];
    }
    
}


@end