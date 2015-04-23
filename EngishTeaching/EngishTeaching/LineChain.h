//
//  LineChain.h
//  EngishTeaching
//
//  Created by Danilo Mative on 17/04/15.
//  Copyright (c) 2015 RD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LineKey.h"

@interface LineChain : NSObject

@property NSString *line;
@property NSMutableArray *lineKeys;
@property NSMutableArray *chainForKeys;

-(id)initWithLine: (NSString *)line;
-(LineChain *)nextChainForKeys: (NSArray *)keys;
-(void)addLineChain:(LineChain *)chain forLineKey: (LineKey *)key;
-(BOOL)isFinalLineChain;
-(NSInteger)numberOfKeysNeeded;

@end
