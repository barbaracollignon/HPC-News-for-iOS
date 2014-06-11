//
//  DetailViewController.h
//  hpcnews
//
//  Created by Barbara Collignon on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "bestnews.h"

@interface DetailViewController : UIViewController {
    
           UIView *myview;
           UIWebView *detailWebView;
            NSURL *detailURL;
           UIActivityIndicatorView *activity;
    NSString *tweetcontent;
    UIToolbar *bottomBar;
    UIBarButtonItem *item;
   // int nbtweet;

}


@property (nonatomic,retain) NSURL *detailURL;
@property (nonatomic,retain) NSString *tweetcontent;
@property (nonatomic, retain) IBOutlet UIWebView *detailWebView;
@property (nonatomic, retain) IBOutlet UIView *myview;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activity;
@property (nonatomic, retain) IBOutlet UIToolbar *bottomBar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *item;
 
-(IBAction)AddtoFavorites;

@end
