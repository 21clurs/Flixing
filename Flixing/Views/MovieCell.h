//
//  MovieCell.h
//  Flixing
//
//  Created by Clara Kim on 6/24/20.
//  Copyright © 2020 Clara Kim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RateView/RateView.h"
#import "Movie.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieCell : UITableViewCell
@property (nonatomic, strong) Movie *movie;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (strong, nonatomic) UIVisualEffectView *effectView;
@property (weak, nonatomic) IBOutlet UIImageView *starRatingView;
@property (strong, nonatomic) RateView *ratingView;
@property (weak, nonatomic) IBOutlet UIImageView *bgPosterView;

@end

NS_ASSUME_NONNULL_END
