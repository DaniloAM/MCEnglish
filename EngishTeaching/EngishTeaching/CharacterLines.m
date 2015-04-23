//
//  CharacterLines.m
//  EngishTeaching
//
//  Created by Danilo Mative on 16/04/15.
//  Copyright (c) 2015 RD. All rights reserved.
//

#import "CharacterLines.h"
#import "NPC.h"
#import "LineChain.h"

@implementation CharacterLines

-(LineChain *)lineChainForCityWithInteraction: (NSInteger)interaction {
    
    switch (interaction) {
        case CTNoInteraction: return [self generateLineChainsForString:[self cityNoInteraction]]; break;
        case CTGreatInteraction: return [self generateLineChainsForString:[self cityGreatInteraction]]; break;

    }
    
    return nil;
    
}

-(NSString *)cityNoInteraction {
    return @"01(I don’t have time.),(Get lost.),(Excuse me.),(...)";
}

-(NSString *)cityGreatInteraction {
    return @"07(Good day.),(Hi.),(Hello. What’s up?),(What you need?) C01{[Help],[Food]} C01{[I],[Food]} C02{[Food][ANYKEY]} C03{[Help][ANYKEY]} C04{[YOU][NAME]} C05{[ANYKEY][ANYKEY]} |1(CALL:ShowRestaurant) |2(Food? What?)  C01{[Help],[Food]} C01{[I],[Food]} C02{[Food][ANYKEY]} C03{[Help][ANYKEY]} C04{[YOU][NAME]} C05{[ANYKEY][ANYKEY]} |3(Are you a foreigner?) C06{[YES]} |4(CALL:RandomName) |5(I don’t get it. Bye.) |6(Good luck here.)";
}


-(LineChain *)generateLineChainsForString: (NSString *)string {
    
    int size = [[string substringToIndex:2] intValue];
    
    NSMutableArray *arrayChains = [NSMutableArray array];
    
    for(int x = 0; x < size; x++) {
        LineChain *chain = [[LineChain alloc] init];
        [arrayChains addObject:chain];
    }
    
    string = [string substringFromIndex:2];
    
    NSArray *chainComponent = [string componentsSeparatedByString:@"|"];
    
    
    
    for(int x = 0; x < chainComponent.count; x++) {
    
        NSString *str = [chainComponent objectAtIndex:x];
        NSMutableArray *lines = [NSMutableArray array];
        
        
        //Identify the lines that can happen in the chain
        while (1) {
           
            NSRange range = [str rangeOfString:@"("];
        
            if(range.location == NSNotFound)
                break;
            
            else {
                
                NSString *lineFound = [str substringFromIndex:range.location + 1];
                
                range = [str rangeOfString:@")"];
                str = [str substringFromIndex:range.location + 1];
                
                range = [lineFound rangeOfString:@")"];
                lineFound = [lineFound substringToIndex:range.location];
                
                [lines addObject:lineFound];
                
            }
        }
        
        //Random the line in the lines array and add to the chain
        [[arrayChains objectAtIndex:x] setLine:[lines objectAtIndex:arc4random_uniform((int)lines.count)]];
        
        while(1) {
            
            NSRange range = [str rangeOfString:@"C"];
            
            if(range.location == NSNotFound)
                break;
            
            else {
                
                NSMutableArray *arrayKeys = [NSMutableArray array];
                
                NSString *chainIndex = [str substringToIndex:range.location + 3];
                
                chainIndex = [chainIndex substringFromIndex:range.location + 1];
                
                LineChain *chain = [arrayChains objectAtIndex:chainIndex.intValue];
            
                
                range = [str rangeOfString:@"{"];
                
                NSString *allKey = [str substringFromIndex:range.location + 1];
                
                range = [allKey rangeOfString:@"}"];
                
                allKey = [allKey substringToIndex:range.location];
                
                //Now that the keys are separated by [str][str], we can get them
                while (1) {
                    
                    range = [allKey rangeOfString:@"["];
                    
                    if(range.location == NSNotFound)
                        break;
                    
                    NSString *newKey = [allKey substringFromIndex:range.location + 1];
                    
                    range = [allKey rangeOfString:@"]"];
                    allKey = [allKey substringFromIndex:range.location + 1];
                    
                    range = [newKey rangeOfString:@"]"];
                    newKey = [newKey substringToIndex:range.location];
                    
                    [arrayKeys addObject:newKey];
                    
                }
                
                range = [str rangeOfString:@"}"];
                str = [str substringFromIndex:range.location + 1];
                
                LineChain *main = [arrayChains objectAtIndex:x];
                
                LineKey *lineKey = [[LineKey alloc] initWithKeys:arrayKeys];
  
                [main addLineChain:chain forLineKey:lineKey];
                
            }
            
        }
    
    }
    
    LineChain *chain = [arrayChains objectAtIndex:0];
    
    return chain;
}


@end
