//
//  NPC.h
//  Teste
//
//  Created by Danilo Mative on 16/04/15.
//  Copyright (c) 2015 FDJ. All rights reserved.
//
//
//
//  Character Types
//
//  CTNoInteraction - doesnt interact with the player at all.
//  CTSmallInteraction - interact with the player, but doesnt offer any progress or dictionary words.
//  CTGreatInteraction - interact with the player and offers words and/or progress.
//

#import <SpriteKit/SpriteKit.h>
#import "LineChain.h"

@interface NPC : SKSpriteNode


typedef enum CharacterTypes {
    CTNoInteraction,
    CTSmallInteraction,
    CTGreatInteraction
}CharacterTypes;

@property CharacterTypes types;

@property LineChain *chain;
@property SKTexture *characterPicture;
@property int characterType;
@property NSMutableArray *characterLines;
@property NSString *progressKey;



@end
