//
//  DictionaryScene.h
//  exSKSpriteKit
//
//  Created by Rodrigo P. Assunção on 4/14/15.
//  Copyright (c) 2015 Rodrigo P. Assunção. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Dictionary.h"
#import "DictionaryDelegate.h"

@interface DictionaryScene : SKScene

@property id<DictionaryDelegate> dictionaryDelegate;
@property BOOL answerMode;

-(void) startScene;

@end
