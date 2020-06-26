//
//  DetailsViewController.m
//  Flixing
//
//  Created by Clara Kim on 6/24/20.
//  Copyright © 2020 Clara Kim. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UIImageView *backdropView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    // this type of stuff belongs in a model class, but we'll do that later
    
    self.titleLabel.text = self.movie[@"title"];
    self.descriptionLabel.text = self.movie[@"overview"];
    
    [self.titleLabel sizeToFit]; // Adjust label to fit whatever is in it now
    [self.descriptionLabel sizeToFit];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
