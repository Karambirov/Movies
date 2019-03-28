//
//  EKPopularMoviesViewController.m
//  Movies
//
//  Created by Eugene Karambirov on 28/03/2019.
//  Copyright © 2019 Eugene Karambirov. All rights reserved.
//

#import "EKPopularMoviesViewController.h"
#import "Masonry/Masonry.h"

@interface EKPopularMoviesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UITableView *tableView;

@end

@implementation EKPopularMoviesViewController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialSetup];
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    return cell;
}

#pragma mark - Setup
- (void)initialSetup {
    self.tableView = [UITableView new];
    self.tableView.backgroundColor = UIColor.whiteColor;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;

    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        Find out why constraining to Safe Area doesn't work.
//        make.edges.equalTo(self.view.mas_safeAreaLayoutGuide);
        make.edges.equalTo(self.view);
    }];
}

@end
