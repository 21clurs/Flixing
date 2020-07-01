//
//  MovieAPIManager.h
//  Flixing
//
//  Created by Clara Kim on 7/1/20.
//  Copyright © 2020 Clara Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieAPIManager : NSObject
@property (nonatomic, strong) NSURLSession *session;

- (void)fetchNowPlaying:(void(^)(NSArray *movies, NSError *error))completion;
- (id)init;

@end

NS_ASSUME_NONNULL_END
