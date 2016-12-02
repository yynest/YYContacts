//
//  ViewController.m
//  YYContacts
//
//  Created by iosdev on 2016/12/2.
//  Copyright © 2016年 QSYJ. All rights reserved.
//

#import "ViewController.h"
#import "SingleContactVC.h"
#import "MultipleContactsTVC.h"
#import "SingleContactDetailVC.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{
    CGRect viewRect;
    NSArray *dataList;
}

@end

@implementation ViewController

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"模式";
    dataList = @[@"单选",@"多选",@"单个查看"];
    
    viewRect = self.view.frame;
    viewRect.origin.y -= 1;
    UITableView *baseTableView = [[UITableView alloc] initWithFrame:viewRect style:UITableViewStyleGrouped];
    baseTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    baseTableView.delegate = self;
    baseTableView.dataSource = self;
    baseTableView.backgroundColor = [UIColor whiteColor];
    //1.分割线从最左边开始绘制
    baseTableView.separatorInset = UIEdgeInsetsZero;
    baseTableView.layoutMargins = UIEdgeInsetsZero;
    baseTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    baseTableView.separatorColor = [UIColor grayColor];
    [self.view addSubview:baseTableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//2.分割线从最左边开始绘制
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *strCell = @"strCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSInteger row = indexPath.row;
    cell.textLabel.text = dataList[row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    UIViewController *vc;
    switch (row) {
        case 0: {
            vc = [[SingleContactVC alloc] init];
        }
            break;
        case 1: {
            vc = [[MultipleContactsTVC alloc] init];
        }
            break;
        case 2: {
            vc = [[SingleContactDetailVC alloc] init];
        }
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
}


@end
