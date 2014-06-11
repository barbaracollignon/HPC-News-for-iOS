//
//  bestnews.h
//  HPC News
//
//  Created by Barbara Collignon on 10/10/11.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

//NSString *tweetlink_global;
NSMutableArray *tweetlink_global;
//int *nbtweet=0;

@interface bestnews : NSObject {    
    
    
    NSString *tweet;
    NSString *tweet2;
    NSString *tweetlink;
    NSString *tweetlink2;
    NSString *createdAt;
     
}

@property (nonatomic,retain) NSString *tweet;
@property (nonatomic,retain) NSString *tweet2;
@property (nonatomic,retain) NSString *tweetlink;
@property (nonatomic,retain) NSString *tweetlink2;
@property (nonatomic,retain) NSString *createdAt;

@end
