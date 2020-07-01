//
//  Movie.m
//  Flixing
//
//  Created by Clara Kim on 7/1/20.
//  Copyright © 2020 Clara Kim. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (id) initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    self.title = dictionary[@"title"];
    self.overview = dictionary[@"overview"];
    
    NSNumber *rating = dictionary[@"vote_average"];
    self.ratingFloat = [rating floatValue]/2;
    
    self.votes = [dictionary[@"vote_count"] floatValue];
    self.videoBool = [dictionary[@"video"] boolValue];
    
    self.movieID = dictionary[@"id"];
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    if(dictionary[@"poster_path"] != nil){
        NSString *fullPosterURLString = [baseURLString stringByAppendingString: dictionary[@"poster_path"]];
        self.posterURL = [NSURL URLWithString:fullPosterURLString];
    }
    if(dictionary[@"backdrop_path"] != nil){
        NSString *fullBackdropURLString = [baseURLString stringByAppendingString: dictionary[@"backdrop_path"]];
        self.backdropURL = [NSURL URLWithString:fullBackdropURLString];
    }
    
    return self;
}

+ (NSArray *)moviesWithDictionaries:(NSArray *)dictionaries{
    NSMutableArray *movies = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in dictionaries) {
        Movie *movie = [[Movie alloc] initWithDictionary:dictionary];
        [movies addObject:movie];
    }
    return movies;
}

@end
