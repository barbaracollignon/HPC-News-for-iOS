//
//  RootViewController2.m
//  PimpGloves_TEST
//
//  Created by Barbara Collignon on 11/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//


#import "RootViewController2.h"
#import "DetailViewController.h"
#import "Favorites.h"
//#import "JSONFlickrViewController.h"
#import "JSON.h"

#define debug(format, ...) CFShow([NSString stringWithFormat:format, ## __VA_ARGS__]);

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * Private interface definitions
 *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
@interface RootViewController2(private)
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
- (void)searchFlickrPhotos:(NSString *)text;
- (void)searchFlickrPhotos2:(NSString *)text;
@end

//#error
// Replace with your Flickr key
NSString *const FlickrAPIKey = @"1a303ca7c10fa2a1d26e00cf0553bfea";
NSString *const userid = @"52210018@N06";
NSString *const groupid = @"72157627879677415";
NSString *const setid = @"72157627879677415";


//me
NSString *const userid2 = @"68382871@N05";
NSString *const groupid2 = @"72157627879677415";

@implementation RootViewController2

@synthesize myBOOL;
@synthesize delegate;

/**************************************************************************
 *
 * Private implementation section
 *
 **************************************************************************/

#pragma mark -
#pragma mark Private Methods

/*-------------------------------------------------------------
 *
 *------------------------------------------------------------*/


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    // receiveData.length=0;
    [receiveData setLength:0];
}

//-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
//    [receiveData appendData:data];
//}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [receiveData release];
    receiveData=nil;
    [connection release];
    connection=nil;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    [delegate flickrConnection:self didReceiveData:receiveData];
 //   [connection release];
 //    connection=nil;  
    
   // jsonString=nil;
    
    NSLog(@"BEFORE1");
    
 if (receiveData != nil) {
        NSString *jsonString=[[NSString alloc] initWithData:receiveData encoding:NSUTF8StringEncoding];
       
    //   if (jsonString == nil) {
        //    jsonString=[[NSMutableString alloc] initWithString:tempString];
            // [tempString release];
            // tempString=nil;
      //  } else {
            
      //      [jsonString appendString:tempString];
           
      //  }
        
      //  [tempString release];
      //  tempString=nil;
        
        
         NSLog(@"BEFORE");
        //	NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        debug(@"jsonString: %@", jsonString);
        NSLog(@"here");
        // Create a dictionary from the JSON string
        if([jsonString JSONValue] != nil){
            NSDictionary *results = [jsonString JSONValue];
         
            NSLog(@"here again");
            // Build an array from the dictionary for easy access to each entry
            // if([[results objectForKey:@"photos"] objectForKey:@"photo"] != 0){
            // if(results objectForKey:@"photos" != nil){  
     //    
            NSArray *photos=nil;
         
        
            
            if (myBOOL == YES) {
               // NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                photos = [[results objectForKey:@"photoset"] objectForKey:@"photo"];
               // [prefs setObject:photos forKey:@"dictionary"];
               // [prefs synchronize];
                NSLog(@"MYBOOL=YES");
            } else {
                NSLog(@"MYBOOL=NO");
                
                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                photos = [[results objectForKey:@"photoset"] objectForKey:@"photo"];
                [prefs removeObjectForKey:@"dictionary"];
                [prefs setObject:photos forKey:@"dictionary"];
                [prefs synchronize];
               // photos=nil;
            }
            
       //     myBOOL = NO;

                
                  
             NSLog(@"here again2");
            // Loop through each entry in the dictionary...
            for (NSDictionary *photo in photos)
            {
                // Get title of the image
                //  while (photo!=nil){
                //   if(photo != nil){
                NSString *title = [photo objectForKey:@"title"];
                NSLog(@"mytitle:%@",title);
                // Save the title to the photo titles array
                [photoTitles addObject:(title.length > 0 ? title : @"Untitled")];
                 NSLog(@"here again3");
                // Build the URL to where the image is stored (see the Flickr API)
                // In the format http://farmX.static.flickr.com/server/id/secret
                // Notice the "_s" which requests a "small" image 75 x 75 pixels
                //   if([photo objectForKey:@"secret"] != nil){
                NSLog(@"TITLE FOR CATALOGUE:%@",title);  
                
                NSString *photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_s.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
                
                 NSLog(@"here again4");
                //    debug(@"photoURLString: %@", photoURLString);
                
                // The performance (scrolling) of the table will be much better if we
                // build an array of the image data here, and then add this data as
                // the cell.image value (see cellForRowAtIndexPath:)
                [photoSmallImageData addObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:photoURLString]]];
                
                // Build and save the URL to the large image so we can zoom
                // in on the image if requested
                photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_m.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
                [photoURLsLargeImage addObject:[NSURL URLWithString:photoURLString]];        
            }
            //  debug(@"photoURLsLareImage: %@\n\n", photoURLString); 
        }
        // }
        // Update the table with data
        // [theTableView reloadData];
        // }
     
      //  if(myBOOL == YES){
        [theTableView reloadData];
       // }
            
        
        [jsonString release];
        jsonString=nil;
        
         NSLog(@"here again6");
        
    }    
    
    [receiveData release];
    receiveData=nil;
  //  [connection release];
  //  connection=nil;

     
     
     
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
    // Store incoming data into a string
   
  [receiveData appendData:data];
 //  NSString *tempString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
   // jsonString=Nil;
    
}



/*-------------------------------------------------------------
 *
 *------------------------------------------------------------*/
-(void)searchFlickrPhotos:(NSString *)text
{
    // Build the string to call the Flickr API
    //	NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&group_id=%@&user_id=%@&per_page=15&format=json&nojsoncallback=1", FlickrAPIKey, text,groupid,userid];
    
    myBOOL=YES;
    
 //   NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&user_id=%@&per_page=15&format=json&nojsoncallback=1", FlickrAPIKey,text,userid];
    
 //   NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=%@&photoset_id=72157627879677415&per_page=50&format=json&nojsoncallback=1",FlickrAPIKey];
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=%@&photoset_id=72157628113067064&per_page=200&format=json&nojsoncallback=1",FlickrAPIKey];
    
   //  NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=%@&photoset_id=72157628102620461&per_page=200&format=json&nojsoncallback=1",FlickrAPIKey];
    
    // Create NSURL string from formatted string
	NSURL *url = [NSURL URLWithString:urlString];
    
    // Setup and start async download
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [request release]; 
   

    if(connection){
        
        if (receiveData != nil) {
            [receiveData release];
            receiveData = nil;
        }
        receiveData=[[NSMutableData data] retain];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        //        [connection release];
        //        connection=nil;
    } else {
          NSLog(@"search could not be performed");
    }

    
    [connection release];
   // [request release];
    
}
-(void)searchFlickrPhotos2:(NSString *)text
{
    // Build the string to call the Flickr API
    //	NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&group_id=%@&user_id=%@&per_page=15&format=json&nojsoncallback=1", FlickrAPIKey, text,groupid,userid];

    myBOOL=NO;
    
   //    NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&user_id=%@&per_page=15&format=json&nojsoncallback=1", FlickrAPIKey,text,userid];
    
    //   NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=%@&photoset_id=72157627879677415&per_page=50&format=json&nojsoncallback=1",FlickrAPIKey];
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=%@&photoset_id=72157627879677415&per_page=100&format=json&nojsoncallback=1",FlickrAPIKey];
    
    
    
    // Create NSURL string from formatted string
	NSURL *url = [NSURL URLWithString:urlString];
    
    // Setup and start async download
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [request release];
    
    
    if(connection){
        
        if (receiveData != nil) {
            [receiveData release];
            receiveData = nil;
        }
        receiveData=[[NSMutableData data] retain];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        //        [connection release];
        //        connection=nil;
    } else {
        NSLog(@"search could not be performed");
    }
    
    
    [connection release];
    // [request release];
    
}



/**************************************************************************
 *
 * Class implementation section
 *
 **************************************************************************/

#pragma mark -
#pragma mark Initialization

/*-------------------------------------------------------------
 *
 *------------------------------------------------------------*/
- (id)init
{
    if (self = [super init])
    {
        self.view = [[[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]] autorelease];
        
        myBOOL=NO;
        
        // Create table view
        theTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 640)];
        [theTableView setDelegate:self];
        [theTableView setDataSource:self];
        [theTableView setRowHeight:80];
        [self.view addSubview:theTableView];
        [theTableView setBackgroundColor:[UIColor whiteColor]];
        [theTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        // Initialize our arrays
		photoTitles = [[NSMutableArray alloc] init];
		photoSmallImageData = [[NSMutableArray alloc] init];
		photoURLsLargeImage = [[NSMutableArray alloc] init];
        
        // Notice that I am hard-coding the search tag at this point (@"iPhone")    
      //  [self searchFlickrPhotos:@"catalogue"];
       // [self searchFlickrPhotos:@"catalogue"];
       // [self searchFlickrPhotos2:@"customization"];
       // [self searchFlickrPhotos:@"catalogue"];
       // [self searchFlickrPhotos2:@"customization"];
        [self searchFlickrPhotos:@"catalogue"];
    //    [self searchFlickrPhotos2:@"customization"];
        // [self searchFlickrPhotos:@"data"];

        
    }
	return self;
    
}

#pragma mark -
#pragma mark Table Mgmt




/*-------------------------------------------------------------
 *
 *------------------------------------------------------------*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	return 1;
}

/*-------------------------------------------------------------
 *
 *------------------------------------------------------------*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	return [photoTitles count];
}

/*-------------------------------------------------------------
 *
 *------------------------------------------------------------*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cachedCell"];
    if (cell == nil)
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"cachedCell"] autorelease];
    
#if __IPHONE_3_0
    cell.textLabel.text = [photoTitles objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:13.0];
#else
    cell.text = [photoTitles objectAtIndex:indexPath.row];
    cell.font = [UIFont systemFontOfSize:13.0];
#endif
	
	NSData *imageData = [photoSmallImageData objectAtIndex:indexPath.row];
    
#if __IPHONE_3_0
    cell.imageView.image = [UIImage imageWithData:imageData];
#else
	cell.image = [UIImage imageWithData:imageData];
#endif
	
    
    
	return cell;
}

#pragma mark -
#pragma mark Cleanup



/*-------------------------------------------------------------
 *
 *------------------------------------------------------------*/
- (void)dealloc 
{
	[theTableView release];
	[photoTitles release];
	[photoSmallImageData release];
    [photoURLsLargeImage release];
  
       
	[super dealloc];
}

@end
