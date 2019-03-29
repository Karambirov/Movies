//
//  MovieTableViewCell.m
//  Movies
//
//  Created by Eugene Karambirov on 29/03/2019.
//  Copyright © 2019 Eugene Karambirov. All rights reserved.
//

#import "MovieTableViewCell.h"
#import "EKMovie.h"

@interface MovieTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *overviewLabel;
@end

@implementation MovieTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.posterImageView.layer.cornerRadius = 5;
    self.posterImageView.clipsToBounds = YES;
}



#pragma mark - Setup
- (void)setupWithMovie:(EKMovie *)movie {
    
}

@end
