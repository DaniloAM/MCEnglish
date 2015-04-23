//
//  LineChain.m
//  EngishTeaching
//
//  Created by Danilo Mative on 17/04/15.
//  Copyright (c) 2015 RD. All rights reserved.
//

#import "LineChain.h"

@implementation LineChain


-(id)initWithLine: (NSString *)line {
    
    self = [super init];
    
    if(self) {
        
        [self setLine:line];
        [self setLineKeys:[NSMutableArray array]];
        [self setChainForKeys:[NSMutableArray array]];
    }
    
    return self;
    
}

-(LineChain *)nextChainForKeys: (NSArray *)keys {
    
    for(int x = 0; x < [[self lineKeys] count]; x++) {
        
        LineKey *key = [[self lineKeys] objectAtIndex:x];
        
        if([key validForKeys:keys]) {
            return [[self chainForKeys] objectAtIndex:x];
        }
        
    }
    
    return nil;
    
}

-(void)addLineChain:(LineChain *)chain forLineKey: (LineKey *)key {
    
    if(![self lineKeys]) {
        [self setLineKeys:[NSMutableArray array]];
        [self setChainForKeys:[NSMutableArray array]];
    }
    
    [[self lineKeys] addObject:key];
    [[self chainForKeys] addObject:chain];
    
}

-(BOOL)isFinalLineChain {
    if([[self chainForKeys] count] <= 0) {
        return true;
    }
    
    else return false;
}

@end
