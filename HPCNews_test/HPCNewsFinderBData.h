//
//  HPCNewsFinderBData.h
//  HPC News
//
//  Created by Barbara Collignon on 9/4/12.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "TwitterConnection.h"
#import "bestnews.h"

@protocol HPCNewsFinderDelegateBData;

int nbtweet;

@interface HPCNewsFinderBData : NSObject <TwitterConnectionDelegate,NSXMLParserDelegate> {
    
    id <HPCNewsFinderDelegateBData> delegate;
    NSMutableArray *besthpcnews;
    bestnews *currentnews;
  
    NSMutableArray *myarray;
   
    NSMutableString *currentstring;
    NSMutableString *currentstring2;
  
    BOOL isHPCnews;
    
}

@property (nonatomic,retain) NSMutableArray *myarray;
@property (nonatomic,assign)id <HPCNewsFinderDelegateBData> delegate;


-(void) getHPCNews;

@end

@protocol HPCNewsFinderDelegateBData

-(void)hpcnewsFinderBData:(HPCNewsFinderBData*)finder didFindHPCNews:(NSArray*)news;

@end


