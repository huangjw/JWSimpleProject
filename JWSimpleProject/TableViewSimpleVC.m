//
//  TableViewSimpleVC.m
//  JWSimpleProject
//
//  Created by huangjw on 2017/1/6.
//  Copyright © 2017年 huangjw. All rights reserved.
//

#import "TableViewSimpleVC.h"
#import "ArrayDataSource.h"

static NSString * const TableViewCellIdentifier = @"TableViewCell";

@interface TableViewSimpleVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) ArrayDataSource *arrayDataSource;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TableViewSimpleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
    self.title = @"TableViewSimple";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.frame;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                  style:UITableViewStylePlain];

        _arrayDataSource = [[ArrayDataSource alloc] initWithItems:[self items] cellIdentifier:TableViewCellIdentifier configureCellBlock:^(UITableViewCell *cell, NSString *item) {
            cell.textLabel.text = item;
        }];;
        _tableView.delegate = self;
        _tableView.dataSource = _arrayDataSource;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TableViewCellIdentifier];
        
    }
    return _tableView;
}

- (NSArray *)items
{
    return @[@"first", @"second", @"3"];
}

@end
