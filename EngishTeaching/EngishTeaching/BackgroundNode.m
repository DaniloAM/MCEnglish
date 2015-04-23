//
//  BackgroundNode.m
//  EngishTeaching
//
//  Created by Danilo Mative on 23/04/15.
//  Copyright (c) 2015 RD. All rights reserved.
//

#import "BackgroundNode.h"

@implementation BackgroundNode

-(void)addChild:(SKNode *)node {
    [super addChild:node];
    
    if([node.name isEqualToString:@"npc"]) {
        if(![self npcArray]) {
            [self setNpcArray:[NSMutableArray array]];
        }
        
        [[self npcArray] addObject:node];
    }
}

@end
