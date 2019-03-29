//
//  MovieTableViewCell.h
//  Movies
//
//  Created by Eugene Karambirov on 29/03/2019.
//  Copyright © 2019 Eugene Karambirov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKMovie.h"

@interface MovieTableViewCell : UITableViewCell

- (void)setupWithMovie:(EKMovie *)movie;

@end

