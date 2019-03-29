//
//  MovieTableViewCell.m
//  Movies
//
//  Created by Eugene Karambirov on 29/03/2019.
//  Copyright © 2019 Eugene Karambirov. All rights reserved.
//

#import "MovieTableViewCell.h"
#import "EKNetworkingService.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIView+WebCache.h>

@interface MovieTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *overviewLabel;
@end

@implementation MovieTableViewCell

#pragma mark - Setup
- (void)prepareForReuse {
    [super prepareForReuse];
    [self resetViews];
}

#pragma mark - Setup
- (void)setupWithMovie:(EKMovie *)movie {
    self.titleLabel.text    = movie.title;
    self.ratingLabel.text   = movie.voteAverage;
    self.overviewLabel.text = movie.overview;

    [self setupPosterImageView];
    [self.posterImageView sd_setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.posterImageView sd_setShowActivityIndicatorView:YES];
    [self.posterImageView sd_setImageWithURL:[EKNetworkingService createImageUrlForPath:movie.posterPath]];
}

- (void)setupPosterImageView {
    self.posterImageView.layer.cornerRadius = 5;
    self.posterImageView.clipsToBounds = YES;
}

- (void)resetViews {
    self.titleLabel.text       = nil;
    self.ratingLabel.text      = nil;
    self.overviewLabel.text    = nil;
    self.posterImageView.image = nil;
}

@end
