//
//  EKNetworkingService.h
//  Movies
//
//  Created by Eugene Karambirov on 28/03/2019.
//  Copyright © 2019 Eugene Karambirov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EKNetworkingService : NSObject

+ (NSMutableURLRequest *)createGetRequestForPath:(NSString *)path withQueryItems:(NSArray<NSURLQueryItem *> *)queryItems;
+ (void)executeRequest:(NSURLRequest *)request withCompletionHandler:(void (^)(id responseData, NSError *error))completionHandler;

@end
