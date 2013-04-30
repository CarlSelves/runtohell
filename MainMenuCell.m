//
//  MainMenuCell.m
//  Run and Roll
//
//  Created by Carl on 13-1-25.
//  Copyright (c) 2013年 Carl Hwang. All rights reserved.
//

#import "MainMenuCell.h"

@implementation MainMenuCell

@synthesize menuLabel;
@synthesize menuImageView;

- (void)setFrame:(CGRect)frame {
    
    CGFloat TABLE_CELL_EXPAND=-10.0f;
    frame.origin.x += 2 * TABLE_CELL_EXPAND;
    frame.origin.y += TABLE_CELL_EXPAND;
    frame.size.width -= 2 * TABLE_CELL_EXPAND;
    frame.size.height = 70.0f;
    [super setFrame:frame];
    
}

@end
