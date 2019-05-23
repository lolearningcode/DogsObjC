//
//  CAPDogBreedTableViewController.m
//  DogsObjC
//
//  Created by Lo Howard on 5/22/19.
//  Copyright © 2019 Lo Howard. All rights reserved.
//

#import "CAPDogBreedTableViewController.h"
#import "CAPDogs.h"
#import "CAPBreedNetworkClient.h"
#import "CAPDogSubBreedTableViewController.h"
#import "CAPImageCollectionViewController.h"

@interface CAPDogBreedTableViewController ()
@property (nonatomic, copy) NSArray *breeds;
@end

@implementation CAPDogBreedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[CAPBreedNetworkClient shared] fetchAllBreeds:^(NSArray *breeds) {
        self.breeds = breeds;
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self tableView] reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.breeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dogCell" forIndexPath:indexPath];
    cell.textLabel.text = [[self.breeds[indexPath.row] name] capitalizedString];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CAPDogs *breed = self.breeds[[[[self tableView] indexPathForSelectedRow] row]];
    if ([breed.subBreeds count] > 0){
        //if there are subBreeds go to the SubBreedTableViewController
        [self performSegueWithIdentifier:@"toSubBreedVC" sender:self];
    } else {
        //if not, go to the ImageCollectionView
        [self performSegueWithIdentifier:@"toCollectionVC" sender:self];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CAPDogs *breed = self.breeds[[[[self tableView] indexPathForSelectedRow] row]];
    //When the segue is about to be performed, determine if the selected Breed has Sub-Breeds
    if ([segue.identifier  isEqualToString: @"toSubBreedVC"])
    {
        //If it's to the SubBreedTableViewController. Send the breed to that landing pad.
        CAPDogSubBreedTableViewController *destinationVC = segue.destinationViewController;
        destinationVC.breed = breed;
        
    } else if([segue.identifier  isEqualToString: @"toCollectionVC"]){
        //If it's to the ImageCollectionView send the breed to that landing pad.
        CAPImageCollectionViewController *destinationVC = segue.destinationViewController;
        destinationVC.breed = breed;
    }
}

@end
