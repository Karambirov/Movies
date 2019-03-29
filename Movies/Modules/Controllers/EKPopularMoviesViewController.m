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
#import "EKMoviesService.h"
#import "MovieTableViewCell.h"

NSString * const cellIdentifier = @"MovieTableViewCell";

@interface EKPopularMoviesViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) UITableView *tableView;
@property (nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic) EKMoviesService *moviesService;
@property (nonatomic) NSArray<EKMovie *> *movies;
@end

@implementation EKPopularMoviesViewController

#pragma mark - Life cycle
- (instancetype)init {
    self = [super init];
    if (!self) return nil;

    self.moviesService = [[EKMoviesService alloc] initWithNetworkingService:[EKNetworkingService new]];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialSetup];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.moviesService fetchPopularMoviesWithCompletionHandler:^(NSArray<EKMovie *> *movies) {
        self.movies = movies;
        [self.activityIndicatorView stopAnimating];
        [self.tableView reloadData];
    }];
    [super viewWillAppear:animated];
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        UINib *nib = [UINib nibWithNibName:cellIdentifier bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    [cell setupWithMovie:self.movies[indexPath.row]];
    return cell;

}

#pragma mark - Setup
- (void)initialSetup {
    self.title = @"Popular";
    [self setupActivityIndicatorView];
    [self setupTableView];
    [self setupConstraints];
}

- (void)setupTableView {
    self.tableView = [UITableView new];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor = UIColor.whiteColor;

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)setupActivityIndicatorView {
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.activityIndicatorView startAnimating];
}

- (void)setupConstraints {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        Find out why constraining to Safe Area doesn't work.
        //        make.edges.equalTo(self.view.mas_safeAreaLayoutGuide);
        make.edges.equalTo(self.view);
    }];

    [self.tableView addSubview:self.activityIndicatorView];
    [self.activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

@end
