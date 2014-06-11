//
//  DetailViewConroller.m
//  hpcnews
//
//  Created by Barbara Collignon on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "bestnews.h"
//#import "HPCNewsFinder.h"

@implementation DetailViewController

@synthesize detailWebView,activity,detailURL,myview,bottomBar,item,tweetcontent;

/*
-(void)loadView{
    
    myview = [[[UIView alloc] init] initWithFrame:CGRectMake(0, 0, 280, 280)]; 
    detailWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 180, 150)];
        
    self.wantsFullScreenLayout = YES;
      
    self.view=myview;
      
    [self.view addSubview:detailWebView];
   //   [self.myview addSubview:activity];

    [detailWebView release];  
    [myview release];
     
    
}
*/

-(IBAction)AddtoFavorites {
   
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    [prefs setObject:self.tweetcontent forKey:@"content"];
    [prefs setURL:self.detailURL forKey:@"url"];
    
    //NSLog(@"detailurl:%@",self.detailURL);
    
    [prefs synchronize];
    
    UIAlertView *alertDialogue;
    
    alertDialogue = [[UIAlertView alloc] initWithTitle:@"Go to Favorites" message:@"Push the Add button" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
 
    [alertDialogue show];
    [alertDialogue release];
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  
    [super viewDidLoad];

    UIBarButtonItem *favbutton = [[UIBarButtonItem alloc] initWithTitle:@"Favorite" style:UIBarButtonItemStylePlain target:self action:@selector(AddtoFavorites)];
    
    self.navigationItem.rightBarButtonItem=favbutton;
    [favbutton release];

         
    [detailWebView loadRequest:[NSURLRequest requestWithURL:detailURL]]; 
    
   

      
   // [self.navigationItem initWithTitle:@"News"];
    [activity startAnimating];

         
  }

-(void)webViewDidFinishLoad:(UIWebView *)WebView
{
 
    [activity startAnimating];
    activity.hidden = YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)dealloc{
    [detailWebView release];
    [activity release];
    [detailURL release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
