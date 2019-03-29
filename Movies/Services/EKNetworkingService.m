//
//  EKNetworkingService.m
//  Movies
//
//  Created by Eugene Karambirov on 28/03/2019.
//  Copyright © 2019 Eugene Karambirov. All rights reserved.
//

#import "EKNetworkingService.h"

NSString * const apiKey = @"f5524bb2a3cfdc23a41b80cc6ec1ad4c";
NSString * const baseUrlString = @"https://api.themoviedb.org";
NSString * const imageUrl = @"https://image.tmdb.org/t/p/w500";

@implementation EKNetworkingService

- (NSURL *)createUrlWithPath:(NSString *)path withQueryItems:(NSArray<NSURLQueryItem *> *)queryItems {
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:baseUrlString];
    urlComponents.path = path;
    urlComponents.queryItems = [@[[NSURLQueryItem queryItemWithName:@"api_key" value:apiKey]]
                                arrayByAddingObjectsFromArray:queryItems];
    NSLog(@"URL: %@", urlComponents.URL);
    return urlComponents.URL;
}

- (NSMutableURLRequest *)createRequestWithMethod:(NSString *)method forURL:(NSURL *)url {

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:60.0f];
    [request setHTTPMethod:method];
    return request;

}

- (void)executeRequest:(NSURLRequest *)request withCompletionHandler:(void (^)(id responseData, NSError *error))completionHandler {

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        if (error) {
            NSLog(@"Network error occurred: %@", [error localizedDescription]);
            dispatch_async(dispatch_get_main_queue(), ^(void){
                completionHandler(nil, error);
            });
            return;
        }

        if ([response isKindOfClass:NSHTTPURLResponse.class]) {
            NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
            if (statusCode != 200) {
                NSLog(@"Network error occurred. Status code: %ld", (long)statusCode);
                return;
            }
        }

        completionHandler(data, nil);

    }];
    [dataTask resume];

}

+ (NSURL *)createImageUrlForPath:(NSString *)path {
    NSURL *url = [NSURL URLWithString:[imageUrl stringByAppendingString:path]];
    return url;
}

@end
