//
//  ViewController.m
//  tableViewDemo
//
//  Created by scl on 2020/2/20.
//  Copyright © 2020 scl. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+ScrollListener.h"
 
@interface Listener : NSObject <UIScrollViewDelegate>


@end

@implementation Listener

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidScroll: Lister(%@)", self);
}

@end

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation ViewController

- (NSMutableArray *)array
{
    if (!_array) {
        _array = [[NSMutableArray alloc] init];
    }
    
    return _array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scl"];
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"点击添加一个Listener", indexPath.row];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

#pragma mark - Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidScroll: ViewController");
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidScrollToTop: ViewController");
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating: ViewController");
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self addAListener];
}

#pragma mark - Private method

- (void)addAListener
{
    Listener *l = [[Listener alloc] init];
    [self.tableView addScrollListener:l];
    [self.array addObject:l];
}

#pragma mark - Getter

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    }
    
    return _tableView;
}

@end
