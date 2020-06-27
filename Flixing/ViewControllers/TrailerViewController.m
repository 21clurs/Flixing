//
//  TrailerViewController.m
//  Flixing
//
//  Created by Clara Kim on 6/26/20.
//  Copyright © 2020 Clara Kim. All rights reserved.
//

#import "TrailerViewController.h"
#import "WebKit/WebKit.h"

@interface TrailerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) NSDictionary *movieInfo;
@property (weak, nonatomic) IBOutlet WKWebView *webkitView;

@end

@implementation TrailerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self fetchTrailer];
    NSURL *videoURL = [NSURL URLWithString:self.videoURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:videoURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    // Load Request into WebView.
    [self.webkitView loadRequest:request];
    
    self.titleLabel.text = self.movieTitle;
}

@end
