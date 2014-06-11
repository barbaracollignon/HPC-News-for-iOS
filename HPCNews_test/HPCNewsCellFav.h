//
//  HPCNewsCell.h
//  HPC News
//
//  Created by Barbara Collignon on 10/10/11.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPCNewsCellFav : UITableViewCell{
    
 
    UILabel *tweetLabel;
    UILabel *tweetLabelLink;
    UILabel *tweetLabelDate;

}

@property (nonatomic, readonly) UILabel *tweetLabel;
@property (nonatomic, readonly) UILabel *tweetLabelLink;
@property (nonatomic, readonly) UILabel *tweetLabelDate;

@end
