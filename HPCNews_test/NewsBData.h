//
//  NewsBData.h
//  HPC News
//
//  Created by Barbara Collignon on 9/4/12.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "TwitterConnection.h"
#import "HPCNewsFinderBData.h"
#import "HPCNewsCellBData.h"


@interface NewsBData : UITableViewController <HPCNewsFinderDelegateBData,ADBannerViewDelegate> {
    
    HPCNewsFinderBData *hpcnewsfinder;
    NSArray *hpcnews;
    UIActivityIndicatorView *activityView;
    ADBannerView *bannerView;
    
}

@property (nonatomic,retain) NSArray *hpcnews;
@property (nonatomic, retain) ADBannerView *bannerView;
@property (nonatomic,assign) BOOL bannerIsVisible;

-(void) refreshNews;

@end
