//
//  RootViewController.m
//  HPC News
//
//  Created by Barbara Collignon on 10/10/11.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//


#import "NewsFeedWire.h"
#import "DetailViewController.h"

static const int rowHeight=117;

@implementation NewsFeedWire

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

-(void)hpcnewsFinderFeedWire:(HPCNewsFinderFeedWire *)finder didFindHPCNews:(NSArray *)news {
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
    
  //  if (Authorization == TRUE) {
      
    self.tableView.rowHeight=rowHeight;
  // [self.navigationItem initWithTitle:@"In The Cloud"];    
    
    self.navigationItem.title=@"Random";
    bannerView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    [self.view addSubview:bannerView];
    [bannerView release];
    
     self.bannerIsVisible = YES;

    
    activityView=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    hpcnewsfinder = [[HPCNewsFinderFeedWire alloc] init];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (hpcnews != nil) {
        return [hpcnews count];
    } else {
    return 0;//[hpcnews count];
    }
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HPCNewsCellFeedWire";
    
    HPCNewsCellFeedWire *cell = (HPCNewsCellFeedWire*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
     
        cell = [[[HPCNewsCellFeedWire alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
  
    }
    
    // Configure the cell..
    bestnews *news=[hpcnews objectAtIndex:indexPath.row];
     bannerView.backgroundColor=tableView.backgroundColor;
   
    
    if(news.tweetlink != nil || news.tweet != Nil || [news.tweet isEqualToString:@""] != TRUE){
        
        
        cell.tweetLabel.text=news.tweet;
        cell.tweetLabelLink.text=news.tweetlink;
        cell.tweetLabelDate.text=news.createdAt;
              
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
  //cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
       
    }
    
   // [news release];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    bestnews *news=[hpcnews objectAtIndex:indexPath.row];
    if(news.tweet.length == 0 ){
        tableView.rowHeight=0; 
        return tableView.rowHeight;
    } else {
        return tableView.rowHeight;
    }
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    bestnews *news=[hpcnews objectAtIndex:indexPath.row];
    
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    
     detailViewController.detailURL=[NSURL URLWithString:news.tweetlink];
     detailViewController.tweetcontent=news.tweet ;
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
  
}

-(void)dealloc{
    [hpcnewsfinder release];
    [hpcnews release];
    [activityView release];
    [super dealloc];
}

@end
