//
//  CAPImageCollectionViewController.h
//  DogsObjC
//
//  Created by Lo Howard on 5/22/19.
//  Copyright © 2019 Lo Howard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAPDogs.h"
#import "CAPDogSubBreed.h"
#import "CAPBreedNetworkClient.h"
#import "CAPDogSubBreedCollectionViewCell.h"
#import "DogsObjCBridgingHeader.h"

NS_ASSUME_NONNULL_BEGIN
@class CAPDogs;
@class CAPDogSubBreed;

@interface CAPImageCollectionViewController : UICollectionViewController

@property (nonatomic, strong) CAPDogs *breed;
@property (nonatomic, strong) CAPDogSubBreed *subBreed;
@property (nonatomic) NSArray *imageURLs;

-(void)fetchImageURLs;

@end

NS_ASSUME_NONNULL_END
