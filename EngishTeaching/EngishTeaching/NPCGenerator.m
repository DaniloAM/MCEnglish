//
//  NPCGenerator.m
//  EngishTeaching
//
//  Created by Danilo Mative on 16/04/15.
//  Copyright (c) 2015 RD. All rights reserved.
//

#import "NPCGenerator.h"

static const uint32_t characterCategory =  0x1 << 1;
static const uint32_t bodyCategory =  0x1 << 2;

@implementation NPCGenerator

-(id)initWithGenerationType: (NSInteger)type spawnRate: (float)seconds inPosition:(CGPoint)point atNode: (SKNode *)node {
    
    self = [super init];
    
    if(self) {
        
        generationType = type;
        spawnRateInSeconds = seconds;
        generatePosition = point;
        nodeInsertion = node;
        
        _stopGenerating = false;

        size = CGSizeMake(50, 50);
        
    }
    
    return self;
}


-(void)addNPCFiles: (NSArray *)files {
    
    if(!generationFiles) {
        generationFiles = [NSMutableArray array];
    }
    
    for(NPCFile *file in files) {
        [generationFiles addObject:file];
    }
    
}


-(void)startGeneratingNPC {
    
    [self generateNewNPC];
    
    //[self performSelectorInBackground:@selector(generateNewNPC) withObject:nil];
}


-(void)generateNewNPC {
    
    int percentualRandom = arc4random_uniform(100);
    int fileRandom = arc4random_uniform(generationFiles.count);
    int randomDirection = arc4random_uniform(4);
    
    NPCFile *file = [generationFiles objectAtIndex:fileRandom];
    
    NPC *new = [[NPC alloc] initWithTexture:file.npcTexture];
    [new setCharacterPicture:file.npcPicture];
    [new setSize:size];
    
    if(generationType == GTCityType) {
        
        if(percentualRandom <= 90) {
            [new setCharacterType:CTNoInteraction];
            
        }
        
        else {
            [new setCharacterType:CTGreatInteraction];
            [new setProgressKey:[self progressKey]];
        }
        
    }
    
    SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:[new size]];
    
    body.density = 100.0;
    body.collisionBitMask = bodyCategory;
    body.contactTestBitMask = characterCategory;
    
    [new setPhysicsBody:body];
    [new setPosition:generatePosition];
    [new setZPosition:1.0];

    [new runAction:[self getDirectionForRandom:randomDirection]];
    
    [self getDirectionForRandom:randomDirection];
    
    [nodeInsertion addChild:new];
    
    if(![self stopGenerating]) {
        [self performSelector:@selector(generateNewNPC) withObject:nil afterDelay:spawnRateInSeconds];
    }
}

-(SKAction *)getDirectionForRandom: (int)rand {
    
    switch (rand) {
        case 0: return [SKAction moveByX:10000 y:0 duration:100.0]; break;
        case 1: return [SKAction moveByX:-10000 y:0 duration:100.0]; break;
        case 2: return [SKAction moveByX:0 y:10000 duration:100.0]; break;
        case 3: return [SKAction moveByX:0 y:-10000 duration:100.0]; break;
        case 4: return [SKAction moveByX:10000 y:10000 duration:100.0]; break;
        case 5: return [SKAction moveByX:10000 y:-10000 duration:100.0]; break;
        case 6: return [SKAction moveByX:-10000 y:10000 duration:100.0]; break;
        case 7: return [SKAction moveByX:-10000 y:-10000 duration:100.0]; break;
        default: return nil;
    }
}



@end