//
//  MovieCell.m
//  Flixing
//
//  Created by Clara Kim on 6/24/20.
//  Copyright © 2020 Clara Kim. All rights reserved.
//

#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"

@implementation MovieCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.bgPosterView sendSubviewToBack:self.posterView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
- (void)setMovie:(Movie *)movie {
    // Since we're replacing the default setter, we have to set the underlying private storage _movie ourselves.
    // _movie was an automatically declared variable with the @propery declaration.
    // You need to do this any time you create a custom setter.
    _movie = movie;

    self.titleLabel.text = self.movie.title;
    self.descriptionLabel.text = self.movie.overview;

    self.posterView.image = nil;
    self.bgPosterView.image = nil;
    if (self.movie.posterURL != nil) {
        [self.posterView setImageWithURL:self.movie.posterURL];
        [self.bgPosterView setImageWithURL:movie.posterURL];
    }
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    if([self.effectView isDescendantOfView:self.bgPosterView]){
        [self.effectView removeFromSuperview];
    }
    self.effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    self.effectView.frame = self.bgPosterView.frame;
    [self.bgPosterView addSubview:self.effectView];
    
    self.ratingView = [RateView rateViewWithRating:self.movie.ratingFloat];
    self.ratingView.starSize = 18;
    [self.starRatingView addSubview:self.ratingView];
}

@end
