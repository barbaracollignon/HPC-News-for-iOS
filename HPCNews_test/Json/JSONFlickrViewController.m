//
//  JSONFlickrViewController.m
//  JSONFlickr
//
//  Created by John on 8/21/09.
//  Copyright iPhoneDeveloperTips.com 2009. All rights reserved.
//

#import "JSONFlickrViewController.h"
#import "JSON.h"

#define debug(format, ...) CFShow([NSString stringWithFormat:format, ## __VA_ARGS__]);

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* Private interface definitions
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
//@interface JSONFlickrViewController(private)
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
//- (void)searchFlickrPhotos:(NSString *)text;
//@end

//#error
// Replace with your Flickr key
NSString *const FlickrAPIKey = @"1a303ca7c10fa2a1d26e00cf0553bfea";
NSString *const userid = @"52210018@N06";
NSString *const groupid = @"72157627879677415";

//me
NSString *const userid2 = @"68382871@N05";
NSString *const groupid2 = @"72157627879677415";

@implementation JSONFlickrViewController

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
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{

    photoTitles = [[NSMutableArray alloc] init];
    photoSmallImageData = [[NSMutableArray alloc] init];
    photoURLsLargeImage = [[NSMutableArray alloc] init];
    
    // Store incoming data into a string
    
	
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

  debug(@"jsonString: %@", jsonString);

  // Create a dictionary from the JSON string
	NSDictionary *results = [jsonString JSONValue];
	
  // Build an array from the dictionary for easy access to each entry
	NSArray *photos = [[results objectForKey:@"photos"] objectForKey:@"photo"];
  
  // Loop through each entry in the dictionary...
	for (NSDictionary *photo in photos)
  {
    // Get title of the image
		NSString *title = [photo objectForKey:@"title"];
      NSLog(@"mytitle:%@",title);
      
      
    // Save the title to the photo titles array
 

      [photoTitles addObject:(title.length > 0 ? title : @"Untitled")];
	
      
         
    // Build the URL to where the image is stored (see the Flickr API)
    // In the format http://farmX.static.flickr.com/server/id/secret
    // Notice the "_s" which requests a "small" image 75 x 75 pixels
		NSString *photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_s.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];

    debug(@"photoURLString: %@", photoURLString);

    // The performance (scrolling) of the table will be much better if we
    // build an array of the image data here, and then add this data as
    // the cell.image value (see cellForRowAtIndexPath:)
		[photoSmallImageData addObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:photoURLString]]];

    // Build and save the URL to the large image so we can zoom
    // in on the image if requested
		photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_m.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
		[photoURLsLargeImage addObject:[NSURL URLWithString:photoURLString]];        
    
    debug(@"photoURLsLareImage: %@\n\n", photoURLString); 
	}
  
  // Update the table with data
//  [theTableView reloadData];

	[jsonString release];

}

/*-------------------------------------------------------------
*
*------------------------------------------------------------*/
-(void)searchFlickrPhotos:(NSString *)text
{

   
    
    // Build the string to call the Flickr API
//	NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&group_id=%@&user_id=%@&per_page=15&format=json&nojsoncallback=1", FlickrAPIKey, text,groupid,userid];
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&user_id=%@&per_page=50&format=json&nojsoncallback=1", FlickrAPIKey,text,userid];
  
  // Create NSURL string from formatted string
	NSURL *url = [NSURL URLWithString:urlString];

  // Setup and start async download
  NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
  NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
  [connection release];
  [request release];
    
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


/*- (id)init
{
  if (self = [super init])
  {
   // self.view = [[[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]] autorelease];

      
    // Create table view
    theTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 240, 320, 220)];
    [theTableView setDelegate:self];
    [theTableView setDataSource:self];
    [theTableView setRowHeight:80];
    [self.view addSubview:theTableView];
    [theTableView setBackgroundColor:[UIColor grayColor]];
    [theTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
       

    // Initialize our arrays
		photoTitles = [[NSMutableArray alloc] init];
		photoSmallImageData = [[NSMutableArray alloc] init];
		photoURLsLargeImage = [[NSMutableArray alloc] init];
    
    // Notice that I am hard-coding the search tag at this point (@"iPhone")    
    [self searchFlickrPhotos:@"customization"];

  }
	return self;

}
*/
/*
#pragma mark -
#pragma mark Table Mgmt

-------------------------------------------------------------
*
*------------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	return 1;
}

-------------------------------------------------------------
*
*------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	return [photoTitles count];
}

-------------------------------------------------------------
*
*------------------------------------------------------------
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


*/

- (void)dealloc 
{
//	[theTableView release];
	[photoTitles release];
	[photoSmallImageData release];
  [photoURLsLargeImage release];
  
	[super dealloc];
}

@end
 