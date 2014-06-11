//
//  DetailViewConroller.m
//  HPC News
//
//  Created by Barbara Collignon on 10/10/11.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import "DetailViewController.h"
#import "bestnews.h"
//#import "HPCNewsFinder.h"

@implementation DetailViewController

@synthesize detailWebView,activity,detailURL,myview,bottomBar,item,tweetcontent;

-(void)AddtoFavorites {
   
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    [prefs setObject:self.tweetcontent forKey:@"content"];
    [prefs setObject:[self.detailURL absoluteString] forKey:@"url"];
     
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

-(void)sendEmail:(id)sender {
    
    MFMailComposeViewController *mailComposer;
    
    mailComposer=[[MFMailComposeViewController alloc] init];
    mailComposer.mailComposeDelegate=self;
  //  mailComposer.title=@"HPC News";
    [mailComposer setMessageBody:[self.detailURL absoluteString] isHTML:NO];
    [mailComposer setSubject:self.tweetcontent];
    
   // [mailComposer setToRecipients:emailAddresses];
    [self presentModalViewController:mailComposer animated:YES];
   // [self resignFirstResponder] ;
   // [emailAddresses release];
    [mailComposer release];
    
}

-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    [self dismissModalViewControllerAnimated:YES];
}



- (void)viewDidLoad
{
  
    [super viewDidLoad];
    
    //[self.view becomeFirstResponder];

    UIBarButtonItem *favbutton = [[UIBarButtonItem alloc] initWithTitle:@"Favorite" style:UIBarButtonItemStylePlain target:self action:@selector(AddtoFavorites)];
    
  //  self.navigationItem.rightBarButtonItem=favbutton;
   // [favbutton release];
    
    UIBarButtonItem *emailbutton = [[UIBarButtonItem alloc] initWithTitle:@"Email A Friend" style:UIBarButtonItemStylePlain target:self action:@selector(sendEmail:)];
    
  //  self.navigationItem.rightBarButtonItem=favbutton;
    NSArray *rightButtonsArray = [[NSArray alloc] initWithObjects:favbutton,emailbutton, nil];
    self.navigationItem.rightBarButtonItems = rightButtonsArray ;
         
    [rightButtonsArray release];
    [favbutton release] ;
    [emailbutton release] ;
    
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
