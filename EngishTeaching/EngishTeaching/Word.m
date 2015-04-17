//
//  Word.m
//  exSKSpriteKit
//
//  Created by Rodrigo P. Assunção on 4/14/15.
//  Copyright (c) 2015 Rodrigo P. Assunção. All rights reserved.
//

#import "Word.h"

@implementation Word

/**
 Inicializa a palavra com seus parametros iniciais
 
 @param original - palavra escrita de forma original, ou seja, em inglês
 @param meaning - significado da palavra, ou seja, em português
 */
- (instancetype)initWithOriginal:(NSString*) original andMeaning:(NSString*) meaning{
    self = [super init];
    if (self) {
        [self setOriginal:original];
        [self setMeaning:meaning];
        [self setIsKnown:NO];
    }
    return self;
}

@end
