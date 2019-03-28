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

NSString * const cellIdentifier = @"PopularMovieCell";

@interface EKPopularMoviesViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) UITableView *tableView;
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

    dispatch_async(dispatch_get_main_queue(), ^{
        self.movies = [self.moviesService fetchPopularMovies];
        [self.tableView reloadData];
    });

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
