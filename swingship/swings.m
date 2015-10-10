//
//  swings.m
//  swingship
//
//  Created by student on 10/10/15.
//  Copyright © 2015 student. All rights reserved.
//

#import "swings.h"
#import <AVFoundation/AVFoundation.h>

@interface swings ()

@end

@implementation swings
{
    UIImageView *ship;
    UIImageView *sea1,*sea2,*sun;
    AVAudioPlayer *audioPlayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawShipAndSea];
    [self animateShip];
    [self animateSea];
    [self playSong];
    
}
-(void) drawShipAndSea {
    sea1 =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sea1.jpg"]];
    sea1.frame = self.view.bounds;
    [self.view addSubview:sea1];
    
    sea2 =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sea1.jpg"]];
    sea2.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.height, self.view.bounds.size.height);
    [self.view addSubview:sea2];
    
    sun = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sun"]];
    sun.center = CGPointMake(280, 320);
    CGRect frames = sun.frame;
    frames.size.width  = 200;
    frames.size.height = 200;
    sun.frame = frames;
    [self.view addSubview:sun];

    ship =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ship"]];
    ship.center= CGPointMake (650,720);
    CGRect frame = ship.frame;
    frame.size.width  = 200;
    frame.size.height = 200;
    ship.frame = frame;
    [self.view addSubview:ship];
    
}

-(void) animateShip {
    [UIView animateWithDuration:1 animations:^{
        ship.transform = CGAffineTransformMakeRotation(-0.08);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1
                         animations:^{
                             ship.transform = CGAffineTransformMakeRotation(0.04);
                         } completion:^(BOOL finished) {
                             [self animateShip];
                         }];
    }];
}

- (void) animateSea {
    [UIView animateWithDuration:10
                     animations:^{
                         sea1.frame = CGRectMake(-self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                         sea2.frame = self.view.bounds;
                     } completion:^(BOOL finished) {
                         sea1.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                         [UIView animateWithDuration:15 animations:^{
                             sea1.frame = self.view.bounds;
                             sea2.frame = CGRectMake(-self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                         } completion:^(BOOL finished) {
                             sea2.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                             [self animateSea];
                         }];
                         
                     }];
}

- (void) playSong {
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"swingsea" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                         error:&error];
    [audioPlayer prepareToPlay];
    [audioPlayer play];
}
- (void) viewWillDisappear:(BOOL)animated {
    [audioPlayer stop];
}


@end
