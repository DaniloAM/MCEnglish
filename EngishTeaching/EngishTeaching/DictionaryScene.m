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

-(instancetype)init{
    if (self) {
        [self setBackgroundColor:[UIColor redColor]];
        [self startScene];
    }
    return self;
}

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


    int i=0;
    for (Word *word in [dic words]) {
        if ([word isKnown]) {
            SKLabelNode *node = [lblWords objectAtIndex:i];
            [node setText: [NSString stringWithFormat:@"%@ - %@", [word original], [word meaning]]];
            i++;
        }
    }

    for (; i<14; i++) {
        SKLabelNode *node = [lblWords objectAtIndex:i];
        [node setText:@""];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![self answerMode]) {
        return;
    }
    for (UITouch *touch in touches) {
        SKLabelNode *node = (SKLabelNode*)[self nodeAtPoint:[touch locationInNode:self.parent]];
        int index = [lblWords indexOfObject:node];

        if (index >= 0 && index <= [lblWords count]) {
            [[self dictionaryDelegate] chosenWord:[[dic words] objectAtIndex:index]];
        }
    }
}

@end
