//
//  NPCGenerator.h
//  EngishTeaching
//
//  Created by Danilo Mative on 16/04/15.
//  Copyright (c) 2015 RD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NPC.h"
#import "NPCFile.h"

@import CoreGraphics;

typedef enum GenerationType {
    GTCityType,
    GTAllRandom,
    GTAllNoInteraction,
    GTAllSmallInteraction,
    GTAllGreatInteraction
}GenerationType;

@interface NPCGenerator : NSObject {
    CGPoint generatePosition;
    float spawnRateInSeconds;
    NSInteger generationType;
    NSMutableArray *generationFiles;
    SKNode *nodeInsertion;
    CGSize size;
}

@property GenerationType genType;
@property BOOL stopGenerating;
@property NSString *progressKey;

-(id)initWithGenerationType: (NSInteger)type spawnRate: (float)seconds inPosition:(CGPoint)point atNode: (SKNode *)node;
-(void)addNPCFiles: (NSArray *)files;
-(void)startGeneratingNPC;

@end