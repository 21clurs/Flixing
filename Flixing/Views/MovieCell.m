//
//  MovieCell.m
//  Flixing
//
//  Created by Clara Kim on 6/24/20.
//  Copyright © 2020 Clara Kim. All rights reserved.
//

#import "MovieCell.h"

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

@end
