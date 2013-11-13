//
//  OptionsSelectLayer.m
//  Dance Wars
//
//  Created by Arnab Banik on 11/9/13.
//  Copyright 2013 Ameya Koshti. All rights reserved.
//

#import "OptionsSelectLayer.h"
#import "CCControlExtension.h"


@implementation OptionsSelectLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	OptionsSelectLayer *layer = [OptionsSelectLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init {
    if((self = [super init])) {
        
        windowSize = [[CCDirector sharedDirector] winSize];
        
        // Add background image
        CCSprite *charBg = [CCSprite spriteWithFile:@"home_bg.png"];
        charBg.position = ccp(windowSize.width/2, windowSize.height/2);
        [self addChild:charBg];
        
        // Create the slider
        CCControlSlider *slider = [CCControlSlider sliderWithBackgroundFile:@"restart.png" progressFile:@"pausegame.png" thumbFile:@"home_pressed.png"];
        slider.minimumValue = 0.0f; // Sets the min value of range
        slider.maximumValue = 1.0f; // Sets the max value of range
        slider.position = ccp(windowSize.width/2, windowSize.height/2);
        
        // When the value of the slider will change, the given selector will be call
        [slider addTarget:self action:@selector(valueChanged:) forControlEvents:CCControlEventValueChanged];
        
        [self addChild:slider];
        
        CCMenuItemImage *mainbutton = [CCMenuItemImage itemWithNormalImage:@"pausegame.png" selectedImage:@"pausegame.png" target:self selector:@selector(loadHelloWorldLayer11)];
        CCMenu *mainMenu = [CCMenu menuWithItems:mainbutton, nil];
        mainMenu.position = ccp(200,200);
        [self addChild:mainMenu];
        
    }
    return self;
}

- (void)valueChanged:(CCControlSlider *)sender
{
    ih = [[InputHandler alloc]init];
    ih2 = [[InputHandler alloc]init];
    // Change volume of your sounds
    [[SimpleAudioEngine sharedEngine] setEffectsVolume:sender.value];
    [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:sender.value];
    
    [ih setVolumeLevel:sender.value];
    [ih2 setCheckvolumeAltered:TRUE];
    sharedManager = [MyManager sharedManager];
    [sharedManager.inputBundle setObject:ih forKey:@"VOLCONTROL"];
    [sharedManager.inputBundle setObject:ih2 forKey:@"VOLCHANGED"];
    
}

//-(void) loadHelloWorldLayer {
//        [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.2 scene:[HelloWorldLayer scene]]];
//}

- (void) loadHelloWorldLayer11 {
    CCScene *helloworldSelect = [HelloWorldLayer scene];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.5 scene:helloworldSelect]];
    
}

@end