//
//  MoviesViewController.m
//  Flixing
//
//  Created by Clara Kim on 6/24/20.
//  Copyright © 2020 Clara Kim. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"
#import "MBProgressHUD/MBProgressHUD.h"

@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, strong) NSArray *filteredMovies;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set datasource and delegate equal to view controller
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.searchBar.delegate = self;
    
    //[self.activityIndicator startAnimating];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [self fetchMovies];
    
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    // Creating a target-action pair
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    //[self.tableView addSubview:self.refreshControl];
}

- (void)fetchMovies {
    
    // Making the network call
    // Setup
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    // Lines inside the block are called once the network call is finished
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
               UIAlertController *alert = [UIAlertController alertControllerWithTitle: @"Cannot Get Movies" message:@"The internet connection appears to be offline" preferredStyle: (UIAlertControllerStyleAlert)];
               UIAlertAction *tryAgainAction = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                   // Handling the Try Again response here
                   [self fetchMovies];
               }];
               
               [alert addAction:tryAgainAction];
               [self presentViewController:alert animated:YES completion:^{}]; // What to do with block syntax when you don't want to do anything?
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               self.movies = dataDictionary[@"results"];
               self.filteredMovies = self.movies;
               
               // Calls datasource method again in case the underlying data has changed
               [self.tableView reloadData];
               
               //[self.activityIndicator stopAnimating];
               [MBProgressHUD hideHUDForView:self.view animated:YES];
               
           }
        [self.refreshControl endRefreshing];
       }];
    [task resume];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.filteredMovies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // UITableViewCell expects to be in a tableView
    // UITableViewCell *cell = [[UITableViewCell alloc] init]; //have to call manual initializer in objective-C
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    NSDictionary *movie = self.filteredMovies[indexPath.row];
    cell.titleLabel.text = movie[@"title"];
    cell.descriptionLabel.text = movie[@"overview"];
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString: posterURLString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    // NSURL is basically the same as an NSString except that it checks if it is a valid URL
    
    cell.posterView.image = nil; // Clear out the previous image
    [cell.posterView setImageWithURL:posterURL];
    
    cell.bgPosterView.image = nil;
    [cell.bgPosterView setImageWithURL:posterURL];
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    if([cell.effectView isDescendantOfView:cell.bgPosterView]){
        [cell.effectView removeFromSuperview];
    }
    cell.effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    cell.effectView.frame = cell.bgPosterView.frame;
    [cell.bgPosterView addSubview:cell.effectView];
    
    //cell.textLabel.text = movie[@"title"];
    //NSLog(@"%@",[NSString stringWithFormat:@"row: %d, section %d", indexPath.row, indexPath.section]);
    //cell.textLabel.text = [NSString stringWithFormat:@"row: %d, section %d", indexPath.row, indexPath.section];
    return cell;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    self.searchBar.showsCancelButton = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    self.searchBar.showsCancelButton = NO;
    self.searchBar.text = @"";
    [self.searchBar resignFirstResponder];
    self.filteredMovies = self.movies;
    [self.tableView reloadData];
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length != 0){
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSDictionary *evaluatedObject, NSDictionary *bindings) {
            return [[evaluatedObject[@"title"] lowercaseString] containsString:[searchText lowercaseString]];
        }];
        self.filteredMovies = [self.movies filteredArrayUsingPredicate:predicate];
    }
    else{
        self.filteredMovies = self.movies;
    }
    [self.tableView reloadData];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // sender: generic word used for the object that fired the event
    UITableViewCell *tappedCell = sender; // In this case the id is the tableView cell that was tapped
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    NSDictionary *movie = self.movies[indexPath.row];
    // casting
    DetailsViewController *detailsViewController = [segue destinationViewController];
    detailsViewController.movie = movie; // It's impolite to try to do too much to it here: keep things separate
}

@end
