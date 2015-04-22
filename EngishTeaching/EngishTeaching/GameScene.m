//
//  GameScene.m
//  Teste
//
//  Created by Danilo Mative on 09/04/15.
//  Copyright (c) 2015 FDJ. All rights reserved.
//

#import "GameScene.h"

static const uint32_t characterCategory =  0x1 << 1;
static const uint32_t bodyCategory =  0x1 << 2;

@implementation GameScene



-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    
    self.physicsWorld.contactDelegate = self;
    
    [self setBase:(SKSpriteNode*)[self childNodeWithName:@"fundo"]];
    [self setCharacter:(SKSpriteNode*)[self childNodeWithName:@"character"]];
    
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
    
    }
    
    
    [[self character] setPosition:CGPointMake(self.size.width/2, self.size.height/2)];
    
    //[[[self character] position]]
    CGPoint point = [self convertPoint:[[self character] position] toNode:[self base]];
    
    NSLog(@"%f %f", point.x, point.y);
    
    generator = [[NPCGenerator alloc] initWithGenerationType:GTCityType spawnRate:2.0 inPosition:CGPointMake(-250, -227) atNode:[self base]];
    
    NPCFile *file1 = [[NPCFile alloc] initWithTextureName:@"LightCharacter.png" andPictureName:@"LightCharacter.png" withGender:1];
    
    NPCFile *file2 = [[NPCFile alloc] initWithTextureName:@"DarkCharacter.png" andPictureName:@"DarkCharacter.png" withGender:0];
    
    [generator addNPCFiles:@[file1, file2]];
    
    [generator startGeneratingNPC];
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    [[self character] runAction:[SKAction moveTo:CGPointMake(self.size.width/2, self.size.height/2) duration:0.1]];
    
    UITouch *touch = [[event allTouches] anyObject];
    
    CGPoint location = [touch locationInNode:self];
    
    CGPoint fundoLocation = [touch locationInNode:self.base];
    
    if([[[self base] nodesAtPoint:fundoLocation] count] > 0) {
        
        for(SKNode *node in [[self base] nodesAtPoint:fundoLocation]) {
            
            if([node.name isEqualToString:@"npc"]) {
                //TALK ACTION
                //***********
            }
            
        }
        
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

    
    NSString *nameA = [[[contact bodyA] node] name];
    NSString *nameB = [[[contact bodyB] node] name];
    
    if([nameA isEqualToString:@"npc"]) {
        
        NSLog(@"Contact! NPC");
        
        if([nameB isEqualToString:@"character"]) {
            //TALK ACTION
            //***********
        }
        
        else [[[contact bodyA] node] removeFromParent];
        
        return;
    }
    
    else if([nameB isEqualToString:@"npc"]) {
        
        NSLog(@"Contact! NPC");
        
        if([nameA isEqualToString:@"character"]) {
            //TALK ACTION
            //***********
        }
        
        else [[[contact bodyB] node] removeFromParent];
        
        return;
    }
    
    
    [[self base] removeAllActions];
    [[self character] runAction:[SKAction moveTo:CGPointMake(self.size.width/2, self.size.height/2) duration:0.1]];
}


@end
