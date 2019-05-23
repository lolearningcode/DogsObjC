//
//  CAPDogSubBreedTableViewController.m
//  DogsObjC
//
//  Created by Lo Howard on 5/22/19.
//  Copyright © 2019 Lo Howard. All rights reserved.
//

#import "CAPDogSubBreedTableViewController.h"
#import "CAPDogs.h"
#import "CAPDogSubBreed.h"
#import "CAPImageCollectionViewController.h"

@interface CAPDogSubBreedTableViewController ()

@end

@implementation CAPDogSubBreedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [self.breed.name capitalizedString];
}

- (void)setBreed:(CAPDogs *)breed
{
    if (breed != _breed) {
        _breed = breed;
        [self.tableView reloadData];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.breed.subBreeds count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dogBreedCell" forIndexPath:indexPath];
    cell.textLabel.text = [[self.breed.subBreeds[indexPath.row] name] capitalizedString];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toSubBreedImages" sender:self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    CAPDogSubBreed *subBreed = self.breed.subBreeds[[[[self tableView] indexPathForSelectedRow] row]];
    if ([segue.identifier isEqualToString:@"toSubBreedImages"]) {
        CAPImageCollectionViewController *destinationVC = segue.destinationViewController;
        destinationVC.subBreed = subBreed;
        destinationVC.breed = self.breed;
    }
}

@end
