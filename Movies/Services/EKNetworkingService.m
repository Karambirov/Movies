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

@implementation EKNetworkingService

+ (NSMutableURLRequest *)createGetRequestForPath:(NSString *)path withQueryItems:(NSArray<NSURLQueryItem *> *)queryItems {
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:baseUrlString];
    urlComponents.path = path;
    urlComponents.queryItems = queryItems;
    NSLog(@"URL: %@", urlComponents.URL);

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlComponents.URL
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:60.0f];
    [request setHTTPMethod:@"GET"];
    return request;
}

+ (void)executeRequest:(NSURLRequest *)request withCompletionHandler:(void (^)(id responseData, NSError *error))completionHandler {
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

        dispatch_async(dispatch_get_main_queue(), ^(void){
            completionHandler(data, nil);
        });

    }];

    [dataTask resume];
}

@end
