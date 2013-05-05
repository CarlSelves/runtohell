//
//  ActivityCell.h
//  Run and Roll
//
//  Created by Joaquin on 13-5-5.
//  Copyright (c) 2013年 Joaquin Hwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *m_DistanceLabel;
@property (strong, nonatomic) IBOutlet UIImageView *m_StatusImage;
@property (strong, nonatomic) IBOutlet UIImageView *m_HonorImage;
@property (strong, nonatomic) IBOutlet UILabel *m_DateLabel;
@property (strong, nonatomic) IBOutlet UILabel *m_TimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *m_SpeedLabel;

@end
