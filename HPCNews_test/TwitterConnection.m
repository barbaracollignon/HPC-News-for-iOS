//
//  TwitterConnection.m
//  HPC News
//
//  Created by Barbara Collignon on 10/10/11.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import "TwitterConnection.h"

@implementation TwitterConnection

@synthesize delegate;

-(void)performSearch:(NSString*) search {
    
    search = [search stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  
    // TW API 1.0
    // NSURL *searchURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://search.twitter.com/search.atom?q=from:%@",search]];
    
    // TW API 1.1
    NSURL *searchURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/1.1/search/tweets.json?q=%@%@",@"%40",search]];
  
    NSURLRequest *request = [NSURLRequest requestWithURL:searchURL cachePolicy:NSURLCacheStorageAllowed timeoutInterval:30.0];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self] ;
    
    if(connection){
        
        if (receiveData != nil) {
            [receiveData release];
            receiveData = nil;
        }
                
        receiveData=[[NSMutableData data] retain];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
    } else {
        NSLog(@"search \"%@\" could not be performed",search);
    }
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    // receiveData.length=0;
    [receiveData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [receiveData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [receiveData release];
    receiveData=nil;
    [connection release];
    connection=nil;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    [delegate twitterConnection:self didReceiveData:receiveData];
    [receiveData release];
    receiveData=nil;
    [connection release];
    connection=nil;

       
}

@end
