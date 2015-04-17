//
//  Dictionary.m
//  exSKSpriteKit
//
//  Created by Rodrigo P. Assunção on 4/14/15.
//  Copyright (c) 2015 Rodrigo P. Assunção. All rights reserved.
//

#import "Dictionary.h"

@implementation Dictionary

+ (Dictionary *) sharedStore
{
    static Dictionary *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[self alloc] init];
    }

    return sharedStore;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self loadWords];
    }
    return self;
}

/**
 Define uma determinada palavra como conhecida

 @param word - palavra a ser alterada (em inglês)
 */
-(void) setWordAsKnown:(NSString*) word{
    for (Word *w in [self words]) {
        if ([w.original isEqual: word]) {
            [w setIsKnown:true];
        }
    }
}

/**
 Verifica se uma determinada palavra é conhecida
 
 @param word - palavra a ser verificada (em inglês)
 */
-(BOOL) wordIsKnown:(NSString*) word{
    for (Word *word in [self words]) {
        if ([word.original isEqual: word]) {
            return word.isKnown;
        }
    }

    return NO;
}


/**
 Carrega todas as palavras, conhecidas ou não, no dicionário
 */
-(void) loadWords{
#warning O ideal é inicializar lendo o conteúdo a partir de um arquivo de texto, porém a fim de teste estou iniciando estáticamente
    Word *w001 = [[Word alloc] initWithOriginal:@"Hello" andMeaning:@"Olá"];
    Word *w002 = [[Word alloc] initWithOriginal:@"Name" andMeaning:@"Nome"];

    [self setWords:[[NSMutableArray alloc] initWithObjects:w001, w002, nil]];
}

@end
