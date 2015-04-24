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
        
        generatingStop = false;

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

-(BOOL)spawnPlaceIsVisibleForScenePosition: (CGPoint)position withSceneSize: (CGSize)sizeScene{

    
    int x1 = generatePosition.x - 40;
    int x2 = x1 - sizeScene.width;
    
    int y1 = generatePosition.y - 40;
    int y2 = y1 - sizeScene.height;
    
    if(position.x > x2 && position.x < x1) {
        if(position.y > y2 && position.y < y2) {
            return true;
        }
    }
    
    return false;
}


-(void)startGeneratingNPC {
    
    generatingStop = false;
    
    if(generateTimer == nil) {
        generateTimer = [NSTimer scheduledTimerWithTimeInterval:spawnRateInSeconds target:self selector:@selector(generateNewNPC) userInfo:nil repeats:true];
    }
    
    //[self performSelectorInBackground:@selector(generateNewNPC) withObject:nil];
}


-(void)generateNewNPC {
    
    int percentualRandom = arc4random_uniform(100);
    int fileRandom = arc4random_uniform((int)generationFiles.count);
    int randomDirection = arc4random_uniform(4);
    
    CharacterLines *lines = [[CharacterLines alloc] init];
    
    NPCFile *file = [generationFiles objectAtIndex:fileRandom];
    
    NPC *new = [[NPC alloc] initWithTexture:file.npcTexture];
    [new setCharacterPicture:file.npcPicture];
    [new setSize:size];
    
    if(generationType == GTCityType) {
        
        if(percentualRandom <= 85) {
            [new setCharacterType:CTNoInteraction];
            
        }
        
        else {
            [new setCharacterType:CTGreatInteraction];
            [new setProgressKey:[self progressKey]];
        }
        
        LineChain *mainChain = [lines lineChainForCityWithInteraction:[new characterType]];
        
        [new setChain:mainChain];
        
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
    
//    if(generatingStop) {
//        return;
//    }
    
    [nodeInsertion addChild:new];
    
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

-(void)stopGenerating {
    generatingStop = true;
    [generateTimer invalidate];
    generateTimer = nil;
}

-(void)createGeneratorsWithType:(NSInteger)type spawnRate:(float)spawn inPositions:(CGPoint *)positions withNPCFiles:(NSArray *)files atNode:(SKNode *)node numberOfGenerators: (NSInteger)number {
    
    NSMutableArray *array = [NSMutableArray array];
    
    for(int x = 0; x < number; x++) {
        NPCGenerator *gen = [[NPCGenerator alloc] initWithGenerationType:type spawnRate:spawn inPosition:positions[x] atNode:node];
        
        [gen addNPCFiles:files];
        
        [array addObject:gen];
    }
    
    generatorsArray = [NSMutableArray arrayWithArray:array];
}


-(void)startGeneratingInAllGenerators {
    if(!generatorsArray) {
        return;
    }
    
    for(int x = 0; x < generatorsArray.count; x++) {
        [[generatorsArray objectAtIndex:x] startGeneratingNPC];
    }
}


-(void)stopGeneratingInAllGenerators {
    if(!generatorsArray) {
        return;
    }
    
    for(int x = 0; x < generatorsArray.count; x++) {
        [[generatorsArray objectAtIndex:x] stopGenerating];
    }
}

-(void)lockAllGeneratorsWhenVisibleForScenePosition: (CGPoint)position andSceneSize: (CGSize)sizeScene{
    
    sceneSize = sizeScene;
    scenePosition = position;
    
    //[self performSelectorInBackground:@selector(lockingForScenePositions) withObject:nil];
    
    [self lockingForScenePositions];
    
}



-(BOOL)lockGeneratorWhenVisibleForScenePosition: (CGPoint)position andSceneSize: (CGSize)sizeScene {
    
    int x1 = self.generatePosition.x + 50;
    int x2 = x1 - sizeScene.width - 50;
    
    int y1 = self.generatePosition.y + 50;
    int y2 = y1 - sizeScene.height - 50;
    
    if(position.x > x2 && position.x < x1) {
        if(position.y > y2 && position.y < y1) {
            
//            if([self isGenerating])
//                [self stopGenerating];
            
            return true;
        }
    }
    
    return false;
    
//    if(!generateTimer) {
//        [self startGeneratingNPC];
//        [self performSelector:@selector(wtf) withObject:nil afterDelay:5.0];
//    }
    
}



-(void)lockingForScenePositions {
    
    for(int x = 0; x < generatorsArray.count; x++) {
        
        NPCGenerator *gen = [generatorsArray objectAtIndex:x];
        
        if([gen lockGeneratorWhenVisibleForScenePosition:scenePosition andSceneSize:sceneSize]) {
            if([gen isGenerating]) {
                [gen stopGenerating];
            }
        }
        
        else {
            if(![gen isGenerating]) {
                [gen startGeneratingNPC];
            }
        }
    
    }
    
}

-(BOOL)isGenerating {
    if(generateTimer) {
        return true;
    }
    
    else return false;
}

-(CGPoint)generatePosition {
    return generatePosition;
}




@end
