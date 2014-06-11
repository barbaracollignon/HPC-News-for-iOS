//
//  JSONFlickrViewController.h
//  JSONFlickr
//
//  Created by John on 8/21/09.
//  Copyright iPhoneDeveloperTips.com 2009. All rights reserved.
//


@protocol FlickrConnectionDelegate; 


@interface JSONFlickrViewController : NSObject
{
//  UITableView     *theTableView;
  id <FlickrConnectionDelegate> delegate;
  
@public
  NSMutableArray  *photoTitles;         // Titles of images
  NSMutableArray  *photoSmallImageData; // Image data (thumbnail)
  NSMutableArray  *photoURLsLargeImage; // URL to larger image 
    
}

@property (nonatomic,assign) id <FlickrConnectionDelegate> delegate;

-(void)searchFlickrPhotos:(NSString *)text;

@end

@protocol FlickrConnectionDelegate

- (void)FlickrConnection:(NSURLConnection *)connection didReceiveData:(NSData *)data;

@end
