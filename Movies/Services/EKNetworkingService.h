//
//  EKNetworkingService.h
//  Movies
//
//  Created by Eugene Karambirov on 28/03/2019.
//  Copyright © 2019 Eugene Karambirov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EKNetworkingService : NSObject

- (NSURL *)createUrlWithPath:(NSString *)path withQueryItems:(NSArray<NSURLQueryItem *> *)queryItems;
- (NSMutableURLRequest *)createRequestWithMethod:(NSString *)method forURL:(NSURL *)url;
- (void)executeRequest:(NSURLRequest *)request withCompletionHandler:(void (^)(id responseData, NSError *error))completionHandler;

+ (NSURL *)createImageUrlForPath:(NSString *)path;

@end
