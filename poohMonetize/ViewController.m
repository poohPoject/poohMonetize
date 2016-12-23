//
//  ViewController.m
//  poohMonetize
//
//  Created by 柯尔祥 on 2016/11/18.
//  Copyright © 2016年 com.kat. All rights reserved.
//

#import "ViewController.h"
#import "PoohMonetizePublic.h"

@interface ViewController ()<GameCenterManagerDelegate>


@property(nonatomic, retain)PoohAdmobInterstitialMonetize* admobInterstitialMonetize;

@property(nonatomic, retain)PoohAdmobNativeMonetize* admobNativeMonetize;

@property(nonatomic, weak) IBOutlet UIView *nativeAdPlaceholder;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton* show = [UIButton buttonWithType:UIButtonTypeSystem];
    [show setTitle:@"展示" forState:UIControlStateNormal];
    [show setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [show setFrame:CGRectMake(100, 100, 100, 50)];
    [self.view addSubview:show];
    
    [show addTarget:self action:@selector(showAdmobInterstitial) forControlEvents:UIControlEventTouchUpInside];

    self.admobNativeMonetize = [[PoohAdmobNativeMonetize alloc]init];
  
    // Set GameCenter Manager Delegate
 //   [[GameCenterManager sharedManager] setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
  /*  BOOL available = [[GameCenterManager sharedManager] checkGameCenterAvailability:YES];
    if (available) {
        [self.navigationController.navigationBar setValue:@"GameCenter Available" forKeyPath:@"prompt"];
    } else {
        [self.navigationController.navigationBar setValue:@"GameCenter Unavailable" forKeyPath:@"prompt"];
    }
    
    GKLocalPlayer *player = [[GameCenterManager sharedManager] localPlayerData];
    if (player) {
        if ([player isUnderage] == NO) {
          //  actionBarLabel.title = [NSString stringWithFormat:@"%@ signed in.", player.displayName];
           // playerName.text = player.displayName;
            //playerStatus.text = @"Player is not underage";
            [[GameCenterManager sharedManager] localPlayerPhoto:^(UIImage *playerPhoto) {
                //playerPicture.image = playerPhoto;
            }];
        } else {
           // playerName.text = player.displayName;
            //playerStatus.text = @"Player is underage";
            //actionBarLabel.title = [NSString stringWithFormat:@"Underage player, %@, signed in.", player.displayName];
        }
    } else {
        //actionBarLabel.title = [NSString stringWithFormat:@"No GameCenter player found."];
    }
   */
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self configBanner];
    [self configAdmobInterstitialMonetize];
 /*   [self.admobNativeMonetize refreshAd:self];
    
    WS(ws);
    self.admobNativeMonetize.click = ^(UIView* adView){
        
        [ws.nativeAdPlaceholder addSubview:adView];
        [adView setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(adView);
        [ws.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_nativeAdView]|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewDictionary]];
        [ws.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_nativeAdView]|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewDictionary]];

    };
 */
}

-(void)showAdmobInterstitial{
    
    [self.admobInterstitialMonetize showGADInterstitial:self];
    [self.admobNativeMonetize refreshAd:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)configBanner{

    PoohAdmobBannerMonetize* bannerMonetize = [[PoohAdmobBannerMonetize alloc]init];
    GADBannerView* banner = [bannerMonetize getBannerObject];
    [banner setFrame:CGRectMake(0, DeviceHeight - POOH_GOOGLE_BANNERVIEW_SIZE_IPHONE,
                                DeviceWidth, POOH_GOOGLE_BANNERVIEW_SIZE_IPHONE)];
    [self.view addSubview:banner];
    [bannerMonetize showGADBannerView:self];
    
}

-(void)configAdmobInterstitialMonetize{
    
    self.admobInterstitialMonetize = [[PoohAdmobInterstitialMonetize alloc]init];

}


#pragma mark - GameCenter Scores

- (IBAction)reportScore {
    [[GameCenterManager sharedManager] saveAndReportScore:[[GameCenterManager sharedManager] highScoreForLeaderboard:@"grp.PlayerScores"]+1 leaderboard:@"grp.PlayerScores" sortOrder:GameCenterSortOrderHighToLow];
    //actionBarLabel.title = [NSString stringWithFormat:@"Score recorded."];
}

- (IBAction)showLeaderboard {
    [[GameCenterManager sharedManager] presentLeaderboardsOnViewController:self withLeaderboard:@"grp.PlayerScores"];
        //actionBarLabel.title = [NSString stringWithFormat:@"Displayed GameCenter Leaderboards."];
}

//------------------------------------------------------------------------------------------------------------//
//------- GameCenter Achievements ----------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------------//
#pragma mark - GameCenter Achievements

- (IBAction)reportAchievement {
    if ([[GameCenterManager sharedManager] progressForAchievement:@"grp.FirstAchievement"] == 100) {
        [[GameCenterManager sharedManager] saveAndReportAchievement:@"grp.SecondAchievement" percentComplete:100 shouldDisplayNotification:YES];
    }
    
    if ([[GameCenterManager sharedManager] progressForAchievement:@"grp.FirstAchievement"] == 0) {
        [[GameCenterManager sharedManager] saveAndReportAchievement:@"grp.FirstAchievement" percentComplete:100 shouldDisplayNotification:YES];
        [[GameCenterManager sharedManager] saveAndReportAchievement:@"grp.SecondAchievement" percentComplete:50 shouldDisplayNotification:NO];
    }
    
    NSLog(@"Achievement One Progress: %f | Achievement Two Progress: %f", [[GameCenterManager sharedManager] progressForAchievement:@"grp.FirstAchievement"], [[GameCenterManager sharedManager] progressForAchievement:@"grp.SecondAchievement"]);
  //  actionBarLabel.title = [NSString stringWithFormat:@"Achievement recorded."];
}

- (IBAction)showAchievements {
    [[GameCenterManager sharedManager] presentAchievementsOnViewController:self];
  //  actionBarLabel.title = [NSString stringWithFormat:@"Displayed GameCenter Achievements."];
}

- (IBAction)resetAchievements {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Really Reset ALL Achievements?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Reset Achievements" otherButtonTitles:nil];
    [actionSheet showInView:self.view];
}

//------------------------------------------------------------------------------------------------------------//
//------- GameCenter Challenges ------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------------//
#pragma mark - GameCenter Challenges

- (IBAction)loadChallenges {
    // This feature is only supported in iOS 6 and higher (don't worry - GC Manager will check for you and return NIL if it isn't available)
    [[GameCenterManager sharedManager] getChallengesWithCompletion:^(NSArray *challenges, NSError *error) {
      //  actionBarLabel.title = [NSString stringWithFormat:@"Loaded GameCenter challenges. Check log."];
        NSLog(@"GC Challenges: %@ | Error: %@", challenges, error);
    }];
}

//------------------------------------------------------------------------------------------------------------//
//------- GameKit Delegate -----------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------------//
#pragma mark - GameKit Delegate

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
    if (gameCenterViewController.viewState == GKGameCenterViewControllerStateAchievements) {
       // actionBarLabel.title = [NSString stringWithFormat:@"Displayed GameCenter achievements."];
    } else if (gameCenterViewController.viewState == GKGameCenterViewControllerStateLeaderboards) {
        //actionBarLabel.title = [NSString stringWithFormat:@"Displayed GameCenter leaderboard."];
    } else {
       // actionBarLabel.title = [NSString stringWithFormat:@"Displayed GameCenter controller."];
    }
}

//------------------------------------------------------------------------------------------------------------//
//------- GameCenter Manager Delegate ------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------------//
#pragma mark - GameCenter Manager Delegate

- (void)gameCenterManager:(GameCenterManager *)manager authenticateUser:(UIViewController *)gameCenterLoginController {
    [self presentViewController:gameCenterLoginController animated:YES completion:^{
        NSLog(@"Finished Presenting Authentication Controller");
    }];
}

- (void)gameCenterManager:(GameCenterManager *)manager availabilityChanged:(NSDictionary *)availabilityInformation {
    NSLog(@"GC Availabilty: %@", availabilityInformation);
    if ([[availabilityInformation objectForKey:@"status"] isEqualToString:@"GameCenter Available"]) {
        [self.navigationController.navigationBar setValue:@"GameCenter Available" forKeyPath:@"prompt"];
       // statusDetailLabel.text = @"Game Center is online, the current player is logged in, and this app is setup.";
    } else {
        [self.navigationController.navigationBar setValue:@"GameCenter Unavailable" forKeyPath:@"prompt"];
     //   statusDetailLabel.text = [availabilityInformation objectForKey:@"error"];
    }
    
    GKLocalPlayer *player = [[GameCenterManager sharedManager] localPlayerData];
    if (player) {
        if ([player isUnderage] == NO) {
          //  actionBarLabel.title = [NSString stringWithFormat:@"%@ signed in.", player.displayName];
          //  playerName.text = player.displayName;
          //  playerStatus.text = @"Player is not underage and is signed-in";
            [[GameCenterManager sharedManager] localPlayerPhoto:^(UIImage *playerPhoto) {
               // playerPicture.image = playerPhoto;
            }];
        } else {
          //  playerName.text = player.displayName;
          //  playerStatus.text = @"Player is underage";
          //  actionBarLabel.title = [NSString stringWithFormat:@"Underage player, %@, signed in.", player.displayName];
        }
    } else {
      //  actionBarLabel.title = [NSString stringWithFormat:@"No GameCenter player found."];
    }
}

- (void)gameCenterManager:(GameCenterManager *)manager error:(NSError *)error {
    NSLog(@"GCM Error: %@", error);
   // actionBarLabel.title = error.domain;
}

- (void)gameCenterManager:(GameCenterManager *)manager reportedAchievement:(GKAchievement *)achievement withError:(NSError *)error {
    if (!error) {
        NSLog(@"GCM Reported Achievement: %@", achievement);
      //  actionBarLabel.title = [NSString stringWithFormat:@"Reported achievement with %.1f percent completed", achievement.percentComplete];
    } else {
        NSLog(@"GCM Error while reporting achievement: %@", error);
    }
}

- (void)gameCenterManager:(GameCenterManager *)manager reportedScore:(GKScore *)score withError:(NSError *)error {
    if (!error) {
        NSLog(@"GCM Reported Score: %@", score);
       // actionBarLabel.title = [NSString stringWithFormat:@"Reported leaderboard score: %lld", score.value];
    } else {
        NSLog(@"GCM Error while reporting score: %@", error);
    }
}

- (void)gameCenterManager:(GameCenterManager *)manager didSaveScore:(GKScore *)score {
    NSLog(@"Saved GCM Score with value: %lld", score.value);
   // actionBarLabel.title = [NSString stringWithFormat:@"Score saved for upload to GameCenter."];
}

- (void)gameCenterManager:(GameCenterManager *)manager didSaveAchievement:(GKAchievement *)achievement {
    NSLog(@"Saved GCM Achievement: %@", achievement);
 //   actionBarLabel.title = [NSString stringWithFormat:@"Achievement saved for upload to GameCenter."];
}

//------------------------------------------------------------------------------------------------------------//
//------- UIActionSheet Delegate -----------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------------//
#pragma mark - UIActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"Reset Achievements"]) {
        [[GameCenterManager sharedManager] resetAchievementsWithCompletion:^(NSError *error) {
            if (error) NSLog(@"Error Resetting Achievements: %@", error);
        }];
    }
}


@end
