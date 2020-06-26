//
//  MovieCell.h
//  Flixing
//
//  Created by Clara Kim on 6/24/20.
//  Copyright © 2020 Clara Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UIImageView *bgPosterView;
@property (strong, nonatomic) UIVisualEffectView *effectView;


@end

NS_ASSUME_NONNULL_END
