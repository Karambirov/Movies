//
//  EKMovie.h
//  Movies
//
//  Created by Eugene Karambirov on 28/03/2019.
//  Copyright © 2019 Eugene Karambirov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EKMovie : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *overview;
@property (nonatomic) NSString *posterPath;
@property (nonatomic) NSString *voteAverage;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)moviesFromDictionaries:(NSArray *)movieDictionaries;

@end
