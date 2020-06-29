//
//  DetailsViewController.m
//  Flixing
//
//  Created by Clara Kim on 6/24/20.
//  Copyright © 2020 Clara Kim. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TrailerViewController.h"
#import "RateView/RateView.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UIImageView *backdropView;
@property (weak, nonatomic) IBOutlet UIImageView *starRatingView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (strong, nonatomic) NSString *videoURLString;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    
    NSString *posterURLString = self.movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString: posterURLString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    [self.posterView setImageWithURL:posterURL];
    
    NSString *backdropURLString = self.movie[@"backdrop_path"];
    if(![backdropURLString isEqual:[NSNull null]]){
        NSString *fullBackdropURLString = [baseURLString stringByAppendingString: backdropURLString];
        NSURL *backdropURL = [NSURL URLWithString:fullBackdropURLString];
        [self.backdropView setImageWithURL: backdropURL];
    }
    else{
        [self.backdropView setImageWithURL:posterURL];
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
        effectView.frame = self.backdropView.frame;
        [self.backdropView addSubview:effectView];
    }
    self.titleLabel.text = self.movie[@"title"];
    self.descriptionLabel.text = self.movie[@"overview"];
    [self.titleLabel sizeToFit]; // Adjust label to fit whatever is in it now
    [self.descriptionLabel sizeToFit];
    
    NSNumber *rating = self.movie[@"vote_average"];
    CGFloat ratingFloat = [rating floatValue]/2;
    RateView* ratingView = [RateView rateViewWithRating:ratingFloat];
    ratingView.starSize = 18;
    [self.starRatingView addSubview:ratingView];
    
    NSNumber *votes = self.movie[@"vote_count"];
    int votesFloat = [votes floatValue];
    self.ratingLabel.text = [NSString stringWithFormat: @"%.2f / %d votes", ratingFloat, votesFloat];
    
    if ([[self.movie objectForKey:@"video"]boolValue] == YES){
        NSString *movieID = self.movie[@"id"];
        NSString *queryString = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed", movieID];
        NSURL *url = [NSURL URLWithString:queryString];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
               if (error != nil) {
                   NSLog(@"%@", [error localizedDescription]);
               }
               else {
                   NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                   NSArray *results = dataDictionary[@"results"];
                   NSDictionary *movieInfo = results[0];
                   self.videoURLString = [NSString stringWithFormat:@"https://www.youtube.com/watch?v=%@", movieInfo[@"key"]];
               }
           }];
        [task resume];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TrailerViewController *trailerView = [segue destinationViewController];
    trailerView.movieTitle = self.movie[@"title"];
    trailerView.videoURLString = self.videoURLString;
}


@end
