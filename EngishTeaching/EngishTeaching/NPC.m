//
//  NPC.m
//  Teste
//
//  Created by Danilo Mative on 16/04/15.
//  Copyright (c) 2015 FDJ. All rights reserved.
//

#import "NPC.h"

@implementation NPC


-(id)initWithColor:(UIColor *)color size:(CGSize)size {
    
    self = [super initWithColor:color size:size];
    
    if(self) {
        [self setName:@"npc"];
    }
    
    return self;
    
}

-(id)initWithImageNamed:(NSString *)name {
    
    self = [super initWithImageNamed:name];
    
    if(self) {
        [self setName:@"npc"];
    }
    
    return self;
    
}

-(id)initWithTexture:(SKTexture *)texture {
    
    self = [super initWithTexture:texture];
    
    if(self) {
        [self setName:@"npc"];
    }
    
    return self;
    
}

-(id)init {
    self = [super init];
    
    if(self) {
        [self setName:@"npc"];
        
    }
    
    return self;
    
}

-(void)runAction:(SKAction *)action withKey:(NSString *)key{
    [super runAction:action withKey:key];
    [self setActionDireciton:action];
    
}

-(void)runAction:(SKAction *)action {
    
    [super runAction:action];
    [self setActionDireciton:action];
}

//-(void)generateNewRandomNPC {
//    [self setName:@"npc"];
//}
//
//-(void)generateNewImportantNPC {
//    
//}




@end
