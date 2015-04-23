//
//  Dictionary.m
//  exSKSpriteKit
//
//  Created by Rodrigo P. Assunção on 4/14/15.
//  Copyright (c) 2015 Rodrigo P. Assunção. All rights reserved.
//

#import "Dictionary.h"

@implementation Dictionary

/**
 Retorna a instancia única do dicionário
 */
+ (Dictionary *) sharedStore
{
    static Dictionary *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[self alloc] init];
    }

    return sharedStore;
}

/**
 Inicia o dicionario, chamando o metodo loadWords
 */
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
    Word *w001 = [[Word alloc] initWithOriginal:@"I" andMeaning:@"Eu"];
    Word *w002 = [[Word alloc] initWithOriginal:@"You" andMeaning:@"Voce"];
    Word *w003 = [[Word alloc] initWithOriginal:@"Yes" andMeaning:@"Sim"];
    Word *w004 = [[Word alloc] initWithOriginal:@"No" andMeaning:@"Não"];
    Word *w005 = [[Word alloc] initWithOriginal:@"Help" andMeaning:@"Ajuda"];
    Word *w006 = [[Word alloc] initWithOriginal:@"Hi" andMeaning:@"Oi"];
    Word *w007 = [[Word alloc] initWithOriginal:@"Name" andMeaning:@"Nome"];
    Word *w008 = [[Word alloc] initWithOriginal:@"Food" andMeaning:@"Comida"];
    Word *w009 = [[Word alloc] initWithOriginal:@"Book" andMeaning:@"Livro"];
    Word *w010 = [[Word alloc] initWithOriginal:@"Table" andMeaning:@"Mesa"];

    [w001 setIsKnown:YES];
    [w002 setIsKnown:YES];
    [w003 setIsKnown:YES];
    [w004 setIsKnown:YES];
    [w005 setIsKnown:YES];
    [w006 setIsKnown:YES];
    [w007 setIsKnown:YES];
    [w008 setIsKnown:YES];
    [w009 setIsKnown:YES];
    [w010 setIsKnown:YES];

    Word *w011 = [[Word alloc] initWithOriginal:@"Sleep" andMeaning:@"Dormir"];

    [self setWords:[[NSMutableArray alloc] initWithObjects:w001, w002, w003, w004, w005, w006, w007, w008, w009, w010, w011, nil]];
    [self sortWordsArray];
}

/**
 Organiza o array de palavras em ordem alfabética
 */
-(void) sortWordsArray{
    NSArray *sortedArray = [[self words] sortedArrayUsingComparator:^NSComparisonResult(id a, id b){
        NSString *w1 = [(Word*) a original];
        NSString *w2 = [(Word*)b original];
        return [w1 compare:w2];
    }];

    [self setWords:[[NSMutableArray alloc] initWithArray:sortedArray]];
}

@end
