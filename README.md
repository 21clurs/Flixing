# Project 2 - *Flixing*

**Flixing** is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Submitted by: **Clara Kim**

Time spent: **18** hours spent in total

## User Stories

The following **required** functionality is complete:

- [x] User sees an app icon on the home screen and a styled launch screen.
- [x] User can view a list of movies currently playing in theaters from The Movie Database.
- [x] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [x] User sees a loading state while waiting for the movies API.
- [x] User can pull to refresh the movie list.
- [x] User sees an error message when there's a networking error.
- [x] User can tap a tab bar button to view a grid layout of Movie Posters using a CollectionView.

The following **optional** features are implemented:

- [x] User can tap a poster in the collection view to see a detail screen of that movie
- [x] User can search for a movie.
- [ ] All images fade in as they are loading.
- [ ] User can view the large movie poster by tapping on a cell.
- [ ] For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
- [ ] Customize the selection effect of the cell.
- [ ] Customize the navigation bar.
- [ ] Customize the UI.

The following **additional** features are implemented:

- [x] User can tap the poster in the detail view In the detail view to see the movie trailer.
- [x] Movie ratings shown with stars in table view and detail view

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Implementation of a search bar in the collection view, as well as keeping the search bar at the top of the scrolling page (i.e. attached to the navigation bar so it doesn't disappear when scrolling down)
2. Embedding trailer video only into the modal view, rather than the entire YouTube web view

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://g.recordit.co/lOjzYtczJg.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

Here's a walkthrough of networking error and refresh:

<img src='http://g.recordit.co/triBNNgnhY.gif' title='Reload Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [Recordit](https://recordit.co/).

## Notes

Describe any challenges encountered while building the app.

- When creating the collectionView, made a class implementing UICollectionViewController instead of UIViewController, caused crashing during tabbing
- When making the backgrounds of the cells in the TableView a blurred version of the movie poster, unintended behavior of blurs layering due to the cell dequeue occurred. The EffectViews had to be checked and removed as 'new' cells appeared.
- Spent a lot of time with the trailer functionality: ran into some issues with webkitView outlets.
- When implementing rating stars, originally attempted to use [HCSStarRatingView](https://github.com/hsousa/HCSStarRatingView), but it was both more complicated to use and didn't have the desired effect.

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library
- [MBProgressHUD](https://github.com/matej/MBProgressHUD) - an iOS activity indicator view
- [RateView](https://github.com/taruntyagi697/RateView) - class for rating view with stars

## License

    Copyright [yyyy] [name of copyright owner]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
