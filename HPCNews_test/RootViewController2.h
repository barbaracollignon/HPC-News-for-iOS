//
//  RootViewController2.h
//  PimpGloves_TEST
//
//  Created by Barbara Collignon on 11/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "JSONFlickrViewController.h"

@class DetailViewController;
@class Favorites;

@protocol FlickrConnectionDelegate;


//Boolean myBOOL=NO;

@interface RootViewController2 : UITableViewController <UITableViewDataSource,UITableViewDelegate> {
    
    
    id <FlickrConnectionDelegate> delegate;
    DetailViewController *detailViewController;
    Favorites *myfavorites;
    //  JSONFlickrViewController *myjson;
    
    UITableView     *theTableView;
  //  NSMutableString *jsonString;
    NSMutableData   *receiveData;
    NSMutableArray  *photoTitles;         // Titles of images
    NSMutableArray  *photoSmallImageData; // Image data (thumbnail)
    NSMutableArray  *photoURLsLargeImage; // URL to larger image 
     UINavigationBar *navigBar;
    Boolean myBOOL;
    int i;

}

@property (nonatomic,assign) id <FlickrConnectionDelegate> delegate;
@property (nonatomic, assign)  Boolean myBOOL;

@end

@protocol FlickrConnectionDelegate

-(void)flickrConnection:(RootViewController2*)connection
          didReceiveData:(NSData*)data;

@end

