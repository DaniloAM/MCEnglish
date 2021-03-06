//
//  DictionaryDelegate.h
//  EngishTeaching
//
//  Created by Rodrigo P. Assunção on 4/16/15.
//  Copyright (c) 2015 RD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Word.h"

@protocol DictionaryDelegate <NSObject>

/**
 Recebe as palavras escolhidas pelo player na cena do dicionário
 */
-(void) chosenWord:(NSMutableArray*)words;

@end
