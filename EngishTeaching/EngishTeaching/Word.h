//
//  Word.h
//  exSKSpriteKit
//
//  Created by Rodrigo P. Assunção on 4/14/15.
//  Copyright (c) 2015 Rodrigo P. Assunção. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Word : NSObject

@property NSString *original;
@property NSString *meaning;

@property BOOL isKnown;

- (instancetype)initWithOriginal:(NSString*) original andMeaning:(NSString*) meaning;

@end
