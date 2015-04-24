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
#import "CharacterLines.h"
#import <CoreGraphics/CoreGraphics.h>

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
    BOOL generatingStop;
    NSTimer *generateTimer;
    NSMutableArray *generatorsArray;
    
    CGSize sceneSize;
    CGPoint scenePosition;
}


@property GenerationType genType;
@property NSString *progressKey;



-(id)initWithGenerationType: (NSInteger)type spawnRate: (float)seconds inPosition:(CGPoint)point atNode: (SKNode *)node;


-(void)createGeneratorsWithType:(NSInteger)type spawnRate:(float)spawn inPositions:(CGPoint *)positions withNPCFiles:(NSArray *)files atNode:(SKNode *)node numberOfGenerators: (NSInteger)number;


-(void)lockAllGeneratorsWhenVisibleForScenePosition: (CGPoint)position andSceneSize: (CGSize)sizeScene;


-(BOOL)lockGeneratorWhenVisibleForScenePosition: (CGPoint)position andSceneSize: (CGSize)sizeScene;


-(void)startGeneratingInAllGenerators;
-(void)stopGeneratingInAllGenerators;
-(void)addNPCFiles: (NSArray *)files;
-(CGPoint)generatePosition;
-(BOOL)isGenerating;
-(void)startGeneratingNPC;
-(void)stopGenerating;

@end
