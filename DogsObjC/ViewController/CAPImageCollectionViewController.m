//
//  CAPImageCollectionViewController.m
//  DogsObjC
//
//  Created by Lo Howard on 5/22/19.
//  Copyright © 2019 Lo Howard. All rights reserved.
//

#import "CAPImageCollectionViewController.h"

@interface CAPImageCollectionViewController ()

@end

@implementation CAPImageCollectionViewController

static NSString * const reuseIdentifier = @"imageCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.breed.name.capitalizedString;
    if(self.subBreed){
        NSString *title = [[self.subBreed.name.capitalizedString stringByAppendingString:@" "] stringByAppendingString:self.breed.name.capitalizedString];
        self.title = title;
    }
    [self fetchImageURLs];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"%li", self.imageURLs.count);
    return self.imageURLs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CAPDogSubBreedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSURL *imageURL = [NSURL URLWithString:self.imageURLs[indexPath.row]];
    cell.imageURL = imageURL;
    return cell;
}


-(void)fetchImageURLs
{
    if (self.subBreed){
        [[CAPBreedNetworkClient shared] fetchSubBreedImageURLs:self.subBreed breed:self.breed completion:^(NSArray *fetchedURLs) {
            self.imageURLs = fetchedURLs;
            dispatch_async(dispatch_get_main_queue(), ^{
                [[self collectionView] reloadData];
            });
        }];
    } else {
        [[CAPBreedNetworkClient shared] fetchBreedImageURLs: self.breed completion:^(NSArray *fetchedURLs) {
            self.imageURLs = fetchedURLs;
            dispatch_async(dispatch_get_main_queue(), ^{
                [[self collectionView] reloadData];
            });
        }];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toDetailVC"])
    {
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems]firstObject];
        NSURL *dogImageURL = [NSURL URLWithString:self.imageURLs[indexPath.row]];
        CAPDetailViewController *destinationVC = segue.destinationViewController;
        destinationVC.dogImageURL = dogImageURL;
        if (self.breed){
            destinationVC.breed = self.breed;
        }
        if (self.subBreed){
            destinationVC.subBreed = self.subBreed;
        }
    }
}
@end
