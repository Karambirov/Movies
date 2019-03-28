//
//  EKMoviesService.h
//  Movies
//
//  Created by Eugene Karambirov on 29/03/2019.
//  Copyright © 2019 Eugene Karambirov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EKNetworkingService.h"
#import "EKMovie.h"

@interface EKMoviesService : NSObject

- (instancetype)initWithNetworkingService:(EKNetworkingService *)networkingService;
- (NSArray<EKMovie *> *)fetchPopularMovies;

@end

