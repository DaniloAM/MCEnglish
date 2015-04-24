//
//  MiniGameScene.h
//  Teste
//
//  Created by Danilo Mative on 13/04/15.
//  Copyright (c) 2015 FDJ. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MiniGameScene : SKScene

@property NSMutableArray *dishes;
@property NSMutableArray *tables;

@property NSString *table;
@property NSString *orderedFood;
@property NSString *firstFood;
@property NSString *secondFood;
@property NSString *thirdFood;

@property NSMutableArray *foodsOptions;

//@property NSInteger tableNumber;
//@property NSInteger orderedIndex;
//@property NSInteger secondIndex;
//@property NSInteger thirdIndex;

@property SKLabelNode *label;

@property SKNode *moving;
@property CGPoint movingPosition;


@property SKNode *npcPicture;
@property NSMutableArray *foodIcon;

@end
