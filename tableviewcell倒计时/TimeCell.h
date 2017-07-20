//
//  TimeCell.h
//  tableviewcell倒计时
//
//  Created by wyb on 2017/7/20.
//  Copyright © 2017年 中天易观. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TimeCellNotification  @"NotificationTimeCell"

@interface TimeCell : UITableViewCell

//作用是只是刷新显示在屏幕上的时间
@property(nonatomic,assign)BOOL isDisplay;

- (void)setSecond:(NSNumber *)second row:(NSInteger) row;

@end
