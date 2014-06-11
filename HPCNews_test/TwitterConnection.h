//
//  TwitterConnection.h
//  HPC News
//
//  Created by Barbara Collignon on 10/10/11.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TwitterConnectionDelegate;


@interface TwitterConnection : NSObject {
    
    id <TwitterConnectionDelegate> delegate;
    NSMutableData *receiveData;
}

@property (nonatomic,assign) id <TwitterConnectionDelegate> delegate;

-(void)performSearch:(NSString*)search;


@end


@protocol TwitterConnectionDelegate

-(void)twitterConnection:(TwitterConnection*)connection
          didReceiveData:(NSData*)data;

@end