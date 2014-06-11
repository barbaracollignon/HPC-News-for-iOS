//
//  HPCNewsCell.m
//  HPC News
//
//  Created by Barbara Collignon on 10/10/11.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import "HPCNewsCell.h"

@implementation HPCNewsCell

@synthesize tweetLabel,tweetLabelLink,tweetLabelDate,mybutton;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
  
       
        UIFont *locationFont = [UIFont fontWithName:@"CourierNewPS-BoldMT" size:16];
        UIFont *locationFont2 = [UIFont fontWithName:@"Arial" size:8];
 
        tweetLabel=[[UILabel alloc] initWithFrame:CGRectMake(15, 8, 270, 100)];
        tweetLabel.textAlignment=UITextAlignmentLeft;
       
        mybutton=[[UIButton alloc] initWithFrame:CGRectMake(275, 50, 20, 20)];
        mybutton.backgroundColor=[UIColor blackColor];
        [tweetLabel addSubview:mybutton];
        [mybutton release];
        
       
        tweetLabel.font=locationFont;
        tweetLabel.numberOfLines=0;
          
        tweetLabelLink=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 280, 100)];
        //  tweetLabel.font=[UIFont systemFontSize:14];
        tweetLabelLink.font=locationFont;
        tweetLabelLink.numberOfLines=6;
        
        tweetLabelDate=[[UILabel alloc] initWithFrame:CGRectMake(10, 90, 80, 20)];
        //  tweetLabel.font=[UIFont systemFontSize:14];
        tweetLabelDate.font=locationFont2;
        tweetLabelDate.numberOfLines=1;
        
        [self.contentView addSubview:tweetLabel];
      //  [self.contentView addSubview:tweetLabelDate];
        
        self.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"twitter-bird-dark-bgs.png"]];
        
        self.tweetLabel.backgroundColor = [UIColor clearColor];

 
    
    }

    return self;
}

-(void)dealloc{
    [tweetLabel release];
    [tweetLabelLink release];
    [tweetLabelDate release];
    [super dealloc];
}

/*
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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
@end
