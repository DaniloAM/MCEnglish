//
//  LineKey.m
//  EngishTeaching
//
//  Created by Danilo Mative on 17/04/15.
//  Copyright (c) 2015 RD. All rights reserved.
//

#import "LineKey.h"

@implementation LineKey

-(id)initWithKeys: (NSArray *)array {
    
    self = [super init];
    
    if(self) {
        
        _keys = [NSArray arrayWithArray:array];
        
    }
    
    return self;
    
}

-(BOOL)validForKeys: (NSArray *)keys {

    for(int x = 0; x < [[self keys] count]; x++) {
        
        NSString *key = [[self keys] objectAtIndex:x];
        
        if(![key isEqualToString:@"ANYKEY"]) {
            
            BOOL notFound = true;
            
            for(int y = 0; y < [keys count]; y++) {
                
                NSString *str = [keys objectAtIndex:y];
                
                if([str isEqualToString:key]) {
                    notFound = false;
                    break;
                }
                
            }
            
            if(notFound) {
                return false;
            }
        }
        
    }
    
    return true;
    
}

@end
