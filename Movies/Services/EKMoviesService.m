//
//  EKMoviesService.m
//  Movies
//
//  Created by Eugene Karambirov on 29/03/2019.
//  Copyright © 2019 Eugene Karambirov. All rights reserved.
//

#import "EKMoviesService.h"

NSString * const kDiscoverMoviePath = @"/3/discover/movie";

@interface EKMoviesService ()
@property (nonatomic) EKNetworkingService* networkingService;
@end

@implementation EKMoviesService

- (instancetype)initWithNetworkingService:(EKNetworkingService *)networkingService {

    self = [super init];
    if (!self) return nil;

    self.networkingService = networkingService;
    return self;

}

- (void)fetchPopularMoviesWithCompletionHandler:(void (^)(NSArray<EKMovie *> *movies))completionHandler {

    NSArray<NSURLQueryItem *> *queryItems = @[[NSURLQueryItem queryItemWithName:@"sort_by" value:@"popularity.desc"]];
    NSURL* url = [self.networkingService createUrlWithPath:kDiscoverMoviePath withQueryItems:queryItems];
    NSMutableURLRequest* request = [self.networkingService createRequestWithMethod:@"GET" forURL:url];

    [self.networkingService executeRequest:request withCompletionHandler:^(id responseData, NSError *error) {
        if (error) {
            NSLog(@"Network error occurred: %@", [error localizedDescription]);
            completionHandler(nil);
            return;
        }

        NSError *parsingError;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&parsingError];

        if (parsingError) {
            NSLog(@"An error occured: %@", [parsingError localizedDescription]);
            completionHandler(nil);
            return;
        }

        dispatch_async(dispatch_get_main_queue(), ^(){
            completionHandler([EKMovie moviesFromDictionaries:json[@"results"]]);
        });
    }];

}

@end
