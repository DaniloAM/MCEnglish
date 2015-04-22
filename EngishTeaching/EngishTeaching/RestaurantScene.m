//
//  RestaurantScene.m
//  EngishTeaching
//
//  Created by Rodrigo P. Assunção on 4/22/15.
//  Copyright (c) 2015 RD. All rights reserved.
//

#import "RestaurantScene.h"

@implementation RestaurantScene

-(BOOL)moveCharacterTo:(UITouch *)touch andLocation:(CGPoint)location{

    CGPoint position = [[self character] position];

    CGPoint movePoint = CGPointMake(location.x - position.x , location.y - position.y);
    double distance = sqrt((movePoint.x * movePoint.x) + (movePoint.y * movePoint.y));

    [[self character] runAction:[SKAction moveTo:location duration:distance * 0.002]];

    return true;
}

@end
