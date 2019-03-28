//
//  EKPopularMoviesViewController.m
//  Movies
//
//  Created by Eugene Karambirov on 28/03/2019.
//  Copyright © 2019 Eugene Karambirov. All rights reserved.
//

#import "Masonry/Masonry.h"

#import "EKPopularMoviesViewController.h"
#import "EKMovie.h"

NSString * const cellIdentifier = @"PopularMovieCell";

@interface EKPopularMoviesViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSArray<EKMovie *> *movies;
@end

@implementation EKPopularMoviesViewController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialSetup];
//    [self fetchPopularMovies];
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = self.movies[indexPath.row].title;
    return cell;
}

#pragma mark - Setup
- (void)initialSetup {
    self.title = @"Popular";
    [self setupTableView];
}

- (void)setupTableView {
    self.tableView = [UITableView new];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    self.tableView.backgroundColor = UIColor.whiteColor;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;

    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        Find out why constraining to Safe Area doesn't work.
        //        make.edges.equalTo(self.view.mas_safeAreaLayoutGuide);
        make.edges.equalTo(self.view);
    }];
}

@end
