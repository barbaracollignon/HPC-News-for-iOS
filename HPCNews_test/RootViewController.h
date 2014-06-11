//
//  RootViewController.h
//  HPC News
//
//  Created by Barbara Collignon on 10/10/11.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "TwitterConnection.h"
#import "HPCNewsFinder.h"
#import "HPCNewsCell.h"


@interface RootViewController : UITableViewController <HPCNewsFinderDelegate,ADBannerViewDelegate> {
    
    HPCNewsFinder *hpcnewsfinder;
    NSArray *hpcnews;
    UIActivityIndicatorView *activityView;
    ADBannerView *bannerView;
    
}

@property (nonatomic,retain) NSArray *hpcnews;
@property (nonatomic, retain) ADBannerView *bannerView;
@property (nonatomic,assign) BOOL bannerIsVisible;

-(void) refreshNews;

@end
