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
    Dictionary *dic;
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

    dic = [Dictionary sharedStore];

    [dic setWordAsKnown:@"Name"];
    [dic setWordAsKnown:@"Hello"];

//    [dic setWordAsKnown:@"Food"];


    int i=0;
    for (Word *word in [dic words]) {
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
        SKLabelNode *node = (SKLabelNode*)[self nodeAtPoint:[touch locationInNode:self.parent]];
        int index = (int)[lblWords indexOfObject:node];
        if (index >= 0 && index <= [lblWords count]) {
            if (index >= 0 && index <= [[dic words] count]) {
                if ([[[dic words] objectAtIndex:index] isKnown]) {
                    [node setFontColor:[UIColor redColor]];
                    [[self dictionaryDelegate] chosenWord:[[dic words] objectAtIndex:index]];
                }
            }
        }
    }
}

@end
