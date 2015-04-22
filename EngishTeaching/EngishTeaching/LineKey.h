//
//  LineKey.h
//  EngishTeaching
//
//  Created by Danilo Mative on 17/04/15.
//  Copyright (c) 2015 RD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LineKey : NSObject

@property NSArray *keys;

-(BOOL)validForKeys: (NSArray *)keys;

@end
