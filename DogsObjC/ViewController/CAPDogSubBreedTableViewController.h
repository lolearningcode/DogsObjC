//
//  CAPDogSubBreedTableViewController.h
//  DogsObjC
//
//  Created by Lo Howard on 5/22/19.
//  Copyright © 2019 Lo Howard. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CAPDogs;

NS_ASSUME_NONNULL_BEGIN

@interface CAPDogSubBreedTableViewController : UITableViewController
@property (nonatomic, copy) CAPDogs *breed;
@end

NS_ASSUME_NONNULL_END
