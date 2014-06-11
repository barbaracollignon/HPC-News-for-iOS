//
//  Favorites.h
//  HPC News
//
//  Created by Barbara Collignon on 10/3/11.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPCNewsCellFav.h"

//Boolean myBOOL=NO;

@interface Favorites : UITableViewController <UITableViewDataSource,UITableViewDelegate> {
//@interface Favorites : UITableViewController {
  
    NSArray *hpcnews;
    NSMutableArray *MyHPCNewsData2;
    NSMutableArray *MyHPCNewsSections2;
    NSMutableArray *sect1MyHPCNewss2;
    NSMutableArray *sect2MyHPCNewss2;
 //   UIImage *myfavimage;
    NSString *myfavtweet;
    NSURL *myfavurl;
    UIActivityIndicatorView *activityView;
 
}

@property (nonatomic, copy, readwrite) NSMutableArray *MyHPCNewsData2;
@property (nonatomic, copy, readwrite) NSMutableArray *MyHPCNewsSections2;
@property (nonatomic, copy, readwrite) NSMutableArray *sect1MyHPCNewss2;
@property (nonatomic, copy, readwrite) NSMutableArray *sect2MyHPCNewss2;
//@property (nonatomic, retain) UIImage *myfavimage;
@property (nonatomic, retain) NSString *myfavtweet;
@property (nonatomic, retain) NSURL *myfavurl;

-(void)getFavorites;
-(void)refreshFavorite;
-(IBAction) createfavorite;

@end
