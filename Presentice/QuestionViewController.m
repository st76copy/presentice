//
//  QuestionViewController.m
//  Presentice
//
//  Created by レー フックダイ on 12/24/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "QuestionViewController.h"

@interface QuestionViewController ()

@end

@implementation QuestionViewController

@synthesize fileLabel;
@synthesize fileName;
@synthesize userLabel;
@synthesize userName;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    fileLabel.text = fileName;
    userLabel.text = userName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    self.movieController = [[MPMoviePlayerController alloc] init];
    
    [self.movieController setContentURL:self.movieURL];
    [self.movieController.view setFrame:CGRectMake(0, 100, 320, 340)];
    [self.view addSubview:self.movieController.view];
    
    // Using the Movie Player Notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.movieController];
    
    
    self.movieController.controlStyle =  MPMovieControlStyleEmbedded;
    self.movieController.shouldAutoplay = YES;
    self.movieController.repeatMode = NO;
    [self.movieController prepareToPlay];
    
    [self.movieController play];
}

- (void)moviePlayBackDidFinish:(NSNotification *)notification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
}
- (void) viewWillDisappear:(BOOL)animated {
    [self.movieController stop];
    [self.movieController.view removeFromSuperview];
    self.movieController = nil;
}


- (IBAction)takeAnswer:(id)sender {}

/**
 * segue for takeAnswer button
 * click to direct to video upload/record view
 * pass questionVideoId
 */

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showPostAnswer"]) {
        PostAnswerViewController *destViewController = segue.destinationViewController;
        destViewController.questionVideoId = self.questionVideoId;
    }
}

@end
