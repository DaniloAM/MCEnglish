//
//  CharacterLines.m
//  EngishTeaching
//
//  Created by Danilo Mative on 16/04/15.
//  Copyright (c) 2015 RD. All rights reserved.
//

#import "CharacterLines.h"
#import "LineChain.h"

@implementation CharacterLines

-(NSMutableArray *)lineChainsForCity {
    
    // 0 - CTNoInteraction
    // 1 - CTGreatInteraction
    
    NSMutableArray *array = [NSMutableArray array];
    
    [array addObject:[[LineChain alloc] initWithLine:[self randomLineCityCTNoInteraction]]];
    
    
    //LineChain *chain1 = [[LineChain alloc] initWithLine:@""]
    
    return array;
    
}

-(NSString *)randomLineCityCTNoInteraction {
    
    int r = arc4random_uniform(4);
    
    switch (r) {
        case 0: return @"I don’t have time."; break;
        case 1: return @"Get lost."; break;
        case 2: return @"Excuse me."; break;
        case 3: return @"..."; break;
    }
    
    return nil;
    
}


-(NSString *)randomLineCityCTGreatInteraction {
    
    int r = arc4random_uniform(4);
    
    switch (r) {
        case 0: return @"Good day."; break;
        case 1: return @"HI."; break;
        case 2: return @"Hello. What's up?"; break;
        case 3: return @"What do you need?"; break;
    }
    
    return nil;
    
}


-(void)t {
    
    LineChain *chain1;
    LineChain *chain2;
    
    LineKey *key;
    
    [chain1 addLineChain:chain2 forLineKey:key];
}

@end
