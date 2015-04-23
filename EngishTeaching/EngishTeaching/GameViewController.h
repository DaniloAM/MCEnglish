//
//  GameViewController.h
//  EngishTeaching
//

//  Copyright (c) 2015 RD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface GameViewController : UIViewController

@property SKScene *currentScene;

@property SKScene *mainScene;
@property SKScene *restaurantScene;

-(void) showScene:(NSString*) sceneName;

@end
