//
//  NPCFile.h
//  EngishTeaching
//
//  Created by Danilo Mative on 17/04/15.
//  Copyright (c) 2015 RD. All rights reserved.
//
//
// ***********************************************************
// * A class that represents the characteristics of the      *
// * characters generated, with texture, picture and gender. *
// ***********************************************************

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface NPCFile : NSObject

@property SKTexture *npcTexture;
@property SKTexture *npcPicture;

// 0 - men
// 1 - woman
@property BOOL gender;

-(id)initWithTextureName: (NSString *)imageName andPictureName: (NSString *)pictureName withGender: (BOOL)gender;

@end
