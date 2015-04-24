//
//  GameViewController.m
//  EngishTeaching
//
//  Created by Danilo Mative on 16/04/15.
//  Copyright (c) 2015 RD. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"
#import "RestaurantScene.h"
#import "MiniGameScene.h"

@implementation SKScene (Unarchive)

+ (instancetype)unarchiveFromFile:(NSString *)file {
    /* Retrieve scene file path from the application bundle */
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    /* Unarchive the file to an SKScene object */
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    
    return scene;
}

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    
    // Create and configure the scene.
    GameScene *scene = [GameScene unarchiveFromFile:@"GameScene"];
    scene.scaleMode = SKSceneScaleModeAspectFill;

    //Set the properties
    [self setMainScene:scene];
    [self setCurrentScene:scene];
    [scene setViewController:self];

    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(void) showScene:(NSString*) sceneName{
        // Configure the view.
    SKView * skView = (SKView *)self.view;

    if ([sceneName isEqualToString:@"MiniGameScene"]) {
        MiniGameScene * scene;
        scene = [MiniGameScene unarchiveFromFile:sceneName];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [self setCurrentScene:scene];
        [skView presentScene:scene];
        return;
    }


        // Create and configure the scene.
    GameScene *scene;
    scene = [GameScene unarchiveFromFile:sceneName];
    scene.scaleMode = SKSceneScaleModeAspectFill;

    if ([self mainScene] == nil) {
        [self setMainScene:scene];
    }
    else if ([self restaurantScene] == nil){
        [self setRestaurantScene:scene];
    }

    if ([sceneName isEqualToString:@"GameScene"]) {
        scene = (GameScene*)[self mainScene];
    }
    else if ([sceneName isEqualToString:@"RestaurantScene"]) {
        scene = (GameScene*)[self restaurantScene];
    }
    else if ([sceneName isEqualToString:@"MinigameScene"]){
            //sasasasaa
    }

        //Set the properties
    [self setCurrentScene:scene];

        // Present the scene.
    [skView presentScene:scene];
}

-(void) showMain{
        // Configure the view.
    SKView * skView = (SKView *)self.view;

        // Create and configure the scene.
    GameScene *scene;
    if ([self restaurantScene] == nil) {
        scene = [GameScene unarchiveFromFile:@"GameScene"];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [self setMainScene:scene];
    }
    else{
        scene = (GameScene*)[self mainScene];
    }

        //Set the properties
    [self setCurrentScene:scene];

        // Present the scene.
    [skView presentScene:scene];
}

@end
