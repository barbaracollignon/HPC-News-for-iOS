//
//  NewsBData.m
//  HPC News
//
//  Created by Barbara Collignon on 9/4/12.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import "NewsBData.h"
#import "DetailViewController.h"
#import "HPCNewsCellBData.h"

static const int rowHeight=117;

@implementation NewsBData

@synthesize hpcnews,bannerView,bannerIsVisible;

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

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!self.bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        banner.frame = CGRectOffset(banner.frame, 0, -50);
      
        [UIView commitAnimations];
        self.bannerIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (self.bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        banner.frame = CGRectOffset(banner.frame, 0, 50);
       
        [UIView commitAnimations];
        self.bannerIsVisible = NO;
    }
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void) refreshNews {
    
    UIBarButtonItem *activityButton = [[UIBarButtonItem alloc] initWithCustomView:activityView];
    self.navigationItem.leftBarButtonItem = activityButton;
    [activityButton release];
    [activityView startAnimating];
    [hpcnewsfinder getHPCNews];
    //  [self.tableView reloadData];
}

- (void)reloadRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    
    
}

-(void)hpcnewsFinderBData:(HPCNewsFinderBData *)finder didFindHPCNews:(NSArray *)news {
    self.hpcnews=news;
    [activityView stopAnimating];
    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshNews)];
    
    self.navigationItem.leftBarButtonItem=refreshButton;
    [refreshButton release];
    [self.tableView reloadData];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.rowHeight=rowHeight;
  
    
    self.navigationItem.title=@"BigData";
    bannerView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    [self.view addSubview:bannerView];
    [bannerView release];
    
    self.bannerIsVisible = YES;
    
    
    activityView=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    hpcnewsfinder = [[HPCNewsFinderBData alloc] init];
    hpcnewsfinder.delegate=self;
    [self refreshNews];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    if (self.bannerView) {
        bannerView.delegate = nil;
        self.bannerView = nil;
    }
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    // return 0;
    // return [hpcnews count];
    return 1;
    //return [];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    // return 0;
    if (hpcnews != nil) {
        return [hpcnews count];
    } else {
        return 0;//[hpcnews count];
    }
    
    // try return 25
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HPCNewsCellBData";
    
    HPCNewsCellBData *cell = (HPCNewsCellBData*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
    if (cell == nil) {
        cell = [[[HPCNewsCellBData alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        //    cell =   [[HPCNewsCell alloc] init];
    }
    
    // Configure the cell..
    
    bestnews *news=[hpcnews objectAtIndex:indexPath.row];
    bannerView.backgroundColor=tableView.backgroundColor;
    //  cell.originLabel.text=news.origin_journal;
    //  cell.destinationLabel.text=news.destination_journal;
    //  cell.priceLabel.text=news.cost_news;
    
    
    if(news.tweetlink != nil || news.tweet != Nil || [news.tweet isEqualToString:@""] != TRUE){
        
        
        cell.tweetLabel.text=news.tweet;
        cell.tweetLabelLink.text=news.tweetlink;
        cell.tweetLabelDate.text=news.createdAt;
        //   news.tweetlink_global=
        
        //  NSLog(@"news in table:%@",cell.tweetLabel.text);
        //  NSLog(@"link in table:%@",cell.tweetLabelLink.text);
        
        /*
         NSLog(@"MYLINK1:%@",@"MYLINK");
         NSLog(@"MYLINK1:%@",@"MYLINK");
         NSLog(@"MYLINK1:%@",@"MYLINK");
         NSLog(@"MYLINK1:%@",news.tweetlink);
         NSLog(@"MYLINK1:%@",@"MYLINK");
         NSLog(@"MYLINK1:%@",@"MYLINK");
         NSLog(@"MYLINK1:%@",@"MYLINK");
         */
        
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        //cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
        
    }
    
    // [news release];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  --CALCULATE THE HEIGHT OF YOUR OWN CELL HERE RESIZE TABLEVIEW--
    
    bestnews *news=[hpcnews objectAtIndex:indexPath.row];
    if(news.tweet.length == 0 ){
        tableView.rowHeight=0;
        return tableView.rowHeight;
    } else {
        return tableView.rowHeight;
    }
    
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    bestnews *news=[hpcnews objectAtIndex:indexPath.row];
    
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    
    
    detailViewController.detailURL=[NSURL URLWithString:news.tweetlink];
    detailViewController.tweetcontent=news.tweet ;
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    //  [news release];
}

-(void)dealloc{
    [hpcnewsfinder release];
    [hpcnews release];
    [activityView release];
    [super dealloc];
}

@end
