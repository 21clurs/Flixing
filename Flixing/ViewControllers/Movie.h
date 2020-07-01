//
//  Movie.h
//  Flixing
//
//  Created by Clara Kim on 7/1/20.
//  Copyright © 2020 Clara Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Movie : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *movieID;
@property (nonatomic, strong) NSURL *posterURL;
@property (nonatomic, strong) NSString *overview;
@property (nonatomic, strong) NSURL *backdropURL;
@property (nonatomic, assign) int votes;
@property (nonatomic, assign) CGFloat ratingFloat;
@property (nonatomic, assign) BOOL videoBool;

- (id) initWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)moviesWithDictionaries:(NSArray *)dictionaries;

@end

NS_ASSUME_NONNULL_END
