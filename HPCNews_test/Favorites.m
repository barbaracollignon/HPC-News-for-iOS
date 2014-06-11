//
//  Favorites.m
//  HPC News
//
//  Created by Barbara Collignon on 10/3/11.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#define sectionCount 1 
#define sect1Section2 0 // Catalogue


#import "Favorites.h"
#import "bestnews.h"
#import "DetailViewController.h"

@class Favorites;

static const int rowHeight=117;

@implementation Favorites

- (id)initWithStyle:(UITableViewStyle)style 
{
    style = UITableViewStyleGrouped;
    
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.tableView.sectionHeaderHeight=51;
        self.tableView.sectionFooterHeight=2;
    }
    return self;
}

@synthesize MyHPCNewsData2,MyHPCNewsSections2,sect1MyHPCNewss2,sect2MyHPCNewss2;
@synthesize myfavtweet,myfavurl;

- (void) refreshFavorite {
    
    UIBarButtonItem *activityButton = [[UIBarButtonItem alloc] initWithCustomView:activityView];
    self.navigationItem.leftBarButtonItem = activityButton;
    [activityButton release];
    [activityView startAnimating];
    [self getFavorites];
}

-(void) getFavorites{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
 

    if ([prefs objectForKey:@"section"] != nil) {
        
        sect1MyHPCNewss2 = [[NSMutableArray alloc] initWithArray:[prefs objectForKey:@"section"]];

    } else {
    
       sect1MyHPCNewss2=[[NSMutableArray alloc] init];
        
    }
    
    self.myfavtweet = [prefs objectForKey:@"content"];
    self.myfavurl = [prefs objectForKey:@"url"];
    
    [sect1MyHPCNewss2 addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:self.myfavtweet,@"name",self.myfavurl,@"url",nil]];
    
    MyHPCNewsData2=[[NSMutableArray alloc] initWithObjects:sect1MyHPCNewss2,nil];
   
    [prefs setObject:sect1MyHPCNewss2 forKey:@"section"];
    [prefs synchronize];
    
    [sect1MyHPCNewss2 release];
    
     sect1MyHPCNewss2=nil;
     
    [activityView stopAnimating];
    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(refreshFavorite)];
    
    self.navigationItem.leftBarButtonItem=refreshButton;
    [refreshButton release];
   [self.tableView reloadData];
}



-(IBAction) createfavorite {
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
       
    if ([prefs objectForKey:@"section"] != nil) {
      
        sect1MyHPCNewss2 = [[NSMutableArray alloc] initWithArray:[prefs objectForKey:@"section"]];
        
    } else {
       
        sect1MyHPCNewss2=[[NSMutableArray alloc] init];
        
    }
    
    MyHPCNewsData2=[[NSMutableArray alloc] initWithObjects:sect1MyHPCNewss2,nil];
    
    [prefs setObject:sect1MyHPCNewss2 forKey:@"section"];
    [prefs synchronize];
    
    [sect1MyHPCNewss2 release];
    
    sect1MyHPCNewss2=nil;
    
    
}


- (void)viewDidLoad
{
    self.navigationItem.title = @"Favorites";
    self.tableView.rowHeight=rowHeight;


    UIBarButtonItem *activityButton = [[UIBarButtonItem alloc] initWithCustomView:activityView];
    self.navigationItem.leftBarButtonItem = activityButton;
    [activityButton release];
    [activityView startAnimating];
  
    [self createfavorite];
    
    
    self.tableView.editing = YES;
    self.tableView.allowsSelectionDuringEditing = YES ;
    
    [activityView stopAnimating];
    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(refreshFavorite)];
    
    self.navigationItem.leftBarButtonItem=refreshButton;
    [refreshButton release];
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
   
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    //return sectionCount;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // return 0;
    return [[MyHPCNewsData2 objectAtIndex:section] count];
   // return [sect1MyHPCNewss2 count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
       
     static NSString *CellIdentifier = @"HPCNewsCellFav";
     
     HPCNewsCellFav *cell = (HPCNewsCellFav*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     if (cell == nil) {
       
         cell = [[[HPCNewsCellFav alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
     
     
     }
    
    
    [[cell tweetLabel] setText:[[[MyHPCNewsData2 objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"name"]];
           
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue ;     
 
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;

}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath
{
    int fromRow = sourceIndexPath.row;
    int toRow = destinationIndexPath.row;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
  
    // Remove item from current position
    NSString *item = [[[MyHPCNewsData2 objectAtIndex:sourceIndexPath.section] objectAtIndex:fromRow]retain];
   
    [[MyHPCNewsData2 objectAtIndex:sourceIndexPath.section] removeObjectAtIndex:fromRow];
    
    // Insert cell at new position
    if (fromRow < toRow) {
        // Moving Down
        if (toRow == [[MyHPCNewsData2 objectAtIndex:destinationIndexPath.section] count])
            // Add to end of cell array
            [[MyHPCNewsData2 objectAtIndex:destinationIndexPath.section] addObject:item];
        else
            [[MyHPCNewsData2 objectAtIndex:destinationIndexPath.section] insertObject:item atIndex:toRow];
    } else {
        // Moving Up
        [[MyHPCNewsData2 objectAtIndex:destinationIndexPath.section] insertObject:item atIndex:toRow];
    }
    [item release];
    
    [prefs setObject:[MyHPCNewsData2 objectAtIndex:destinationIndexPath.section] forKey:@"section"];
}

- (BOOL)table:(UITableView*)table canDeleteRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Remove the item from the table
        [[MyHPCNewsData2 objectAtIndex:indexPath.section] removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
        [prefs setObject:[MyHPCNewsData2 objectAtIndex:indexPath.section] forKey:@"section"];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
  
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
   
    NSMutableArray *myarray = [[[NSMutableArray alloc] initWithArray:[prefs objectForKey:@"section"]] autorelease];
    
    if (myarray == nil) {
    
    }
    
    NSMutableArray *myfinalarray = nil;
    
    myfinalarray = [[[NSMutableArray alloc] initWithObjects:myarray,nil] autorelease];
    
    if (myfinalarray == nil) {
    //    NSLog(@"MyHPCNewsData2 is nil");
    }
    
    NSString *mystringurl = [[[NSString alloc] initWithString:[[[myfinalarray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"url"]]autorelease] ;
    
    detailViewController.detailURL = [NSURL URLWithString:mystringurl] ;
   
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
   
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}

- (void)dealloc
{
    [super dealloc];
    [MyHPCNewsData2 release];
    [myfavurl release];
    [myfavtweet release];

}

@end
