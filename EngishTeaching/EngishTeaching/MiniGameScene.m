//
//  MiniGameScene.m
//  Teste
//
//  Created by Danilo Mative on 13/04/15.
//  Copyright (c) 2015 FDJ. All rights reserved.
//

#import "MiniGameScene.h"

#define numberOptions 3

@implementation MiniGameScene


-(void)didMoveToView:(SKView *)view {
    
    [self setFoodIcon:[NSMutableArray array]];
    
    _label = [[SKLabelNode alloc] init];
    
    [_label setName:@"label"];
    
    [_label setPosition:CGPointMake(self.view.center.x, self.view.center.y * 1.5)];
    
    [_label setFontColor:[UIColor blackColor]];
    [_label setPosition:CGPointMake(580, 620)];
    [_label setText:@"TESTE"];
    
    [_label setFontSize:45.0];
    
    [self addChild:_label];
    
    [self reloadDishesArray];
    [self reloadTableArray];
    [self setFoodsOptions:[NSMutableArray array]];
    
    NSArray *nodes = [self children];
    
    int found = 0;
    
    for(int x = 0; x < [nodes count]; x++) {
        
        SKNode *node = [nodes objectAtIndex:x];
        
        if([node.name isEqualToString:@"movefood"]) {
            node.name = [NSString stringWithFormat:@"%@%d", node.name, found];
            [[self foodIcon] addObject:node];
            found++;
        }
        
    }
    
    [self randomizeNewOrder];
}
    

-(void)randomizeNewOrder {
    
    if([[self tables] count] <= 0) {
        [self reloadTableArray];
    }
    
    int tableNumber = arc4random_uniform((int)[[self tables] count]);
    int orderNumber = arc4random_uniform((int)[[self dishes] count]);
    
    
    [self setTable:[[self tables] objectAtIndex:tableNumber]];
    //[[self tables] removeObjectAtIndex:tableNumber];
    
    [self setOrderedFood:[[self dishes] objectAtIndex:orderNumber]];
    //[[self dishes] removeObjectAtIndex:_orderNumber];
    
    NSMutableArray *random = [NSMutableArray array];
    
    [random addObject:[self orderedFood]];
    
    int secondFoodNumber = orderNumber;
    int thirdFoodNumber = orderNumber;
    
    while (secondFoodNumber == orderNumber) {
        secondFoodNumber = arc4random_uniform((int)[[self dishes] count]);
    }
    
    while (thirdFoodNumber == orderNumber || thirdFoodNumber == secondFoodNumber) {
        thirdFoodNumber = arc4random_uniform((int)[[self dishes] count]);
    }
    
    [random addObject:[[self dishes] objectAtIndex:secondFoodNumber]];
    [random addObject:[[self dishes] objectAtIndex:thirdFoodNumber]];
    
    [[self label] setText:[NSString stringWithFormat:@"%@ at table number %@", [self orderedFood], [self table]]];
    
    while (random.count > 0) {
        int index = arc4random_uniform(random.count);
        [[self foodsOptions] addObject:[random objectAtIndex:index]];
        [random removeObjectAtIndex:index];
    }
    
    
    for(int x = 0; x < [[self foodsOptions] count]; x++) {
        
        NSString *string = [NSString stringWithFormat:@"%@.png",[[self foodsOptions] objectAtIndex:x]];
        
        [[[self foodIcon] objectAtIndex:x] setTexture:[SKTexture textureWithImage:[UIImage imageNamed:string]]];
    }
    
    
    
}

-(void)reloadDishesArray {
    
    _dishes = [NSMutableArray arrayWithArray:[NSArray arrayWithObjects:
                                              @"Pasta",
                                              @"Meat",
                                              @"Bread",
                                              @"Rice",
                                              @"Chicken",
                                              @"Sausage",
                                              @"Salad",
                                              @"French Fries",
                                              @"Popcorn",
                                              @"Pizza",
                                              @"Potato",
                                              @"Cheese", nil]];
    
}

-(void)reloadTableArray {
    
    _tables = [NSMutableArray arrayWithArray:[NSArray arrayWithObjects:
                                              @"One",
                                              @"Two",
                                              @"Three",
                                              @"Four",
                                              @"Five",
                                              @"Six",
                                              @"Seven",
                                              @"Eight",
                                              @"Nine",
                                              @"Ten",
                                              @"Eleven",
                                              @"Twelve", nil]];
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    CGPoint location = [touch locationInNode:self];
    
    NSArray *array = [self nodesAtPoint:location];
    
    for(int x = 0; x < [array count]; x++) {
        SKNode *node = [array objectAtIndex:x];
        
        if ([[node name] rangeOfString:@"movefood"].location != NSNotFound) {
            [self setMoving:node];
            [self setMovingPosition:[[self moving] position]];
            
            NSString *nodeName = [[node name] substringFromIndex: [[node name] length] - 1];
            
            NSLog(@"Food: %@", [[self foodsOptions] objectAtIndex:[nodeName intValue]]);
            
            //for(int x = 0; )
        }
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    CGPoint location = [touch locationInNode:self];
    
    if([self moving] != nil) {
        
        //[[self moving] removeAllActions];
        [[self moving] runAction:[SKAction moveTo:location duration:0.1]];
        
    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    CGPoint location = [touch locationInNode:self];
    
    if([self moving] != nil) {
        
        NSArray *array = [self nodesAtPoint:location];
        
        BOOL found = false;
        
        for(int x = 0; x < [array count]; x++) {
            SKNode *node = [array objectAtIndex:x];
            
            //NSLog(@"%@", node.name);
            
            if ([[node name] rangeOfString:@"table"].location == NSNotFound) {
                
            }
            
            else {
                
                found = true;
                
                NSString *str = [[node name] substringFromIndex: [[node name] length] - 2];
                
                int tableNumber = [str integerValue];
                
                NSLog(@"Mesita numero %d", (int) tableNumber);
                
                NSString *nodeName = [[[self moving] name] substringFromIndex: [[[self moving] name] length] - 1];
                NSString *foodSelected = [[self foodsOptions] objectAtIndex:[nodeName intValue]];
                
                NSString *tableSelected = [[self tables] objectAtIndex:tableNumber - 1];
                
                BOOL correctFood = false, correctTable = false;
                
                if([foodSelected isEqualToString:[self orderedFood]]) {
                    correctFood = true;
                }
                
                if([tableSelected isEqualToString:[self table]]) {
                    correctTable = true;
                }
                
                if(correctFood && correctTable) {
                    NSLog(@"Correct!");
                    [self setFoodsOptions:[NSMutableArray array]];
                    [self randomizeNewOrder];
                }
                
                
            }
            
            
        }
        
//        if(!found) {
//            [[self moving] runAction:[SKAction moveTo:[self movingPosition] duration:0.15]];
//        }
        
        [[self moving] runAction:[SKAction moveTo:[self movingPosition] duration:0.15]];
        [self setMoving:nil];
        
    }
    
}

@end
