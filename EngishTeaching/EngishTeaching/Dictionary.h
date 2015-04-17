//
//  Dictionary.h
//  exSKSpriteKit
//
//  Created by Rodrigo P. Assunção on 4/14/15.
//  Copyright (c) 2015 Rodrigo P. Assunção. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Word.h"

@interface Dictionary : NSObject

@property NSMutableArray *words;

+(Dictionary *) sharedStore;
-(void) setWordAsKnown:(NSString*) word;
-(BOOL) wordIsKnown:(NSString*) word;

@end
