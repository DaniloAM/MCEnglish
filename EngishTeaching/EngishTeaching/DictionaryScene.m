//
//  DictionaryScene.m
//  exSKSpriteKit
//
//  Created by Rodrigo P. Assunção on 4/14/15.
//  Copyright (c) 2015 Rodrigo P. Assunção. All rights reserved.
//

#import "DictionaryScene.h"

@implementation DictionaryScene{
    NSMutableArray *lblWords;
    Dictionary *dictionary;
    NSMutableArray *selectedWords;
    int chosenWords;
}

/**
 Inicia a cena do dicionário, chamando o método startScene
 */
-(instancetype)init{
    if (self) {
        [self startScene];
    }
    return self;
}

/**
 Inicializa a cena, carregando todas as palavras do dicionário e mostrando-as nos SKLabelNodes
 */
-(void) startScene{
//    lblWords = (SKLabelNode*)[self childNodeWithName:@"lblWords"];

    lblWords = [[NSMutableArray alloc] init];
    for (int i=0; i<14; i++) {
        [lblWords setObject:(SKLabelNode*)[self childNodeWithName:[NSString stringWithFormat:@"lblWords%02d", i]] atIndexedSubscript:i];
    }

    if ([lblWords count] <=0) {
        return;
    }

        //Set word as known
    dictionary = [Dictionary sharedStore];
    [dictionary setWordAsKnown:@"Name"];

//    [dic setWordAsKnown:@"Food"];


    int i=0;
    for (Word *word in [dictionary words]) {
        SKLabelNode *node = [lblWords objectAtIndex:i];
        if ([word isKnown]) {
            [node setText: [NSString stringWithFormat:@"%@ - %@", [word original], [word meaning]]];
        }
        else{
            [node setText: [NSString stringWithFormat:@"???????? - ????????"]];
        }
        i++;
    }

    for (; i<14; i++) {
        SKLabelNode *node = [lblWords objectAtIndex:i];
        [node setText:@""];
    }

    selectedWords = [[NSMutabl  eArray alloc] init];
    chosenWords = 0;
}

/**
 Metodo herdado, recebe um toque e o utiliza para definir qual palavra foi escolhida pelo player,
 chamando o método chosenWords do delegate.
 
 Se não estiver no answerMode, ou seja, está no modo de consulta, somente retorna nulo.
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![self answerMode]) {
        return;
    }
    for (UITouch *touch in touches) {

        SKNode *node = [self nodeAtPoint:[touch locationInNode:self.parent]];
        if ([[node name] isEqualToString:@"btnCancel"]) {
            [self clearDictionarySelection];
            return;
        }
        else if ([[node name] isEqualToString:@"btnConfirm"]) {
            if (chosenWords < [self numberOfWordsToChoose] || chosenWords > [self numberOfWordsToChoose]) {
                return;
            }
            
            [self clearDictionarySelection];
            
            [[self dictionaryDelegate] chosenWord:[NSMutableArray arrayWithArray:selectedWords]];
            
            [selectedWords removeAllObjects];
            return;
        }

        SKLabelNode *lblNode = (SKLabelNode*)[self nodeAtPoint:[touch locationInNode:self.parent]];
        int index = [lblWords indexOfObject:node];
        if (index >= 0 && index <= [lblWords count] && chosenWords < [self numberOfWordsToChoose]) {
            if (index >= 0 && index <= [[dictionary words] count]) {
                if ([[[dictionary words] objectAtIndex:index] isKnown]) {
                    if ([lblNode fontColor] == [UIColor redColor]) {
                        return;
                    }
                    [lblNode setFontColor:[UIColor redColor]];
                    [selectedWords addObject:[[[dictionary words] objectAtIndex:index] original]];
                    chosenWords++;
                    return;
                }
            }
        }
    }
}

-(void) clearDictionarySelection{
    chosenWords = 0;
    for (SKLabelNode *lbl in lblWords) {
        [lbl setFontColor:[UIColor blackColor]];
    }
    selectedWords = [[NSMutableArray alloc] init];
}



@end
