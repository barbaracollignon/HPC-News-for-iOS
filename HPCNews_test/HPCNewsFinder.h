//
//  HPCNewsFinder.h
//  HPC News
//
//  Created by Barbara Collignon on 10/10/11.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TwitterConnection.h"
#import "bestnews.h"

@protocol HPCNewsFinderDelegate; 

int nbtweet;

@interface HPCNewsFinder : NSObject <TwitterConnectionDelegate,NSXMLParserDelegate> {
    
    id <HPCNewsFinderDelegate> delegate;
    NSMutableArray *besthpcnews;
    bestnews *currentnews;
  //  NSString *tweetlink_global;
    NSMutableArray *myarray;
   // int nbtweet;
    NSMutableString *currentstring;
     NSMutableString *currentstring2;
  //  NSString *mydetaillink;
    BOOL isHPCnews;
 
    NSMutableData   *receiveData;
}


@property (nonatomic,retain) NSMutableArray *myarray;
@property (nonatomic,assign)id <HPCNewsFinderDelegate> delegate;
//@property (nonatomic,retain) NSString *mydetaillink;

-(void) getHPCNews;

@end

@protocol HPCNewsFinderDelegate 

-(void)hpcnewsFinder:(HPCNewsFinder*)finder didFindHPCNews:(NSArray*)news;

@end

 

