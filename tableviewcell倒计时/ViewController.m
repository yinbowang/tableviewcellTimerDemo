//
//  ViewController.m
//  tableviewcell倒计时
//
//  Created by wyb on 2017/7/20.
//  Copyright © 2017年 中天易观. All rights reserved.
//

#import "ViewController.h"
#import "TimeCell.h"

static NSString *cellID = @"cellID";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSTimer *timer;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSMutableArray array];
    
    for (int i=0; i<30; i++) {
        
        NSInteger second = 100 + arc4random_uniform(1000);
        [self.dataArray addObject:@(second)];
        
    }
    
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[TimeCell class] forCellReuseIdentifier:cellID];
    [self.view addSubview:self.tableView];
    
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TimeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    [cell setSecond:self.dataArray[indexPath.row] row:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    TimeCell *timeCell = (TimeCell *)cell;
    timeCell.isDisplay = YES;
    [timeCell setSecond:self.dataArray[indexPath.row] row:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    TimeCell *timeCell = (TimeCell *)cell;
    timeCell.isDisplay = NO;
    
}

- (void)timeAction
{
    for (int i=0; i<self.dataArray.count; i++) {
        NSInteger second = [self.dataArray[i] integerValue];
        second = second - 1;
        self.dataArray[i] = @(second);
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:TimeCellNotification object:nil];
}

@end
