//
//  NPCFile.m
//  EngishTeaching
//
//  Created by Danilo Mative on 17/04/15.
//  Copyright (c) 2015 RD. All rights reserved.
//

#import "NPCFile.h"

@implementation NPCFile

-(id)initWithTextureName: (NSString *)imageName andPictureName: (NSString *)pictureName withGender: (BOOL)gender {
    
    self = [super init];
    
    if(self) {
        
        UIImage *textImage = [UIImage imageNamed:imageName];
        UIImage *picImage = [UIImage imageNamed:pictureName];
        
        
        [self setNpcPicture:[SKTexture textureWithImage:picImage]];
        [self setNpcTexture:[SKTexture textureWithImage:textImage]];
        [self setGender:gender];
    }
    
    return self;
    
}

@end
