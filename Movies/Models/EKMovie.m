//
//  EKMovie.m
//  Movies
//
//  Created by Eugene Karambirov on 28/03/2019.
//  Copyright © 2019 Eugene Karambirov. All rights reserved.
//

#import "EKMovie.h"

@implementation EKMovie

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {

    if (self = [super init]) {
        if (dictionary[@"title"]) {
            self.title = dictionary[@"title"];
        }
    }

    return self;

}

+ (NSArray *)moviesFromDictionaries:(NSArray *)movieDictionaries {

    NSMutableArray *movies = [NSMutableArray new];

    for (NSDictionary *movieDict in movieDictionaries) {
        EKMovie *movie = [[EKMovie alloc] initWithDictionary:movieDict];
        [movies addObject:movie];
    }

    return movies;

}

@end
