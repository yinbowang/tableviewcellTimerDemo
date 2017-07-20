//
//  TimeCell.m
//  tableviewcell倒计时
//
//  Created by wyb on 2017/7/20.
//  Copyright © 2017年 中天易观. All rights reserved.
//

#import "TimeCell.h"

@interface TimeCell ()

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)NSNumber *time;
@property(nonatomic,assign)NSInteger row;

@end

@implementation TimeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(notificationCenterEvent)
                                                     name:TimeCellNotification
                                                   object:nil];
        [self loadUI];
        
    }
    return self;
}

- (void)loadUI
{
  
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.titleLabel];
    
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.timeLabel];
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(0, 0, 100, 50);
    self.timeLabel.frame = CGRectMake(self.frame.size.width-100, 0, 100, 50);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)setSecond:(NSNumber *)second row:(NSInteger) row
{
    self.time = second;
    self.row = row;
    self.timeLabel.text = [self currentTimeString];
    self.titleLabel.text = [NSString stringWithFormat:@"%ld",row];
}

- (NSString*)currentTimeString {
    
    NSInteger second = [self.time integerValue];
    if (second <= 0) {
        
        return @"00:00:00";
        
    } else {
        
        return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)second/3600,(long)second%3600/60,(long)second%60];
    }
}

- (void)notificationCenterEvent{
    
    if (self.isDisplay) {
        self.time = @([self.time integerValue] - 1);
        [self setSecond:self.time row:self.row];
    }
}

@end
