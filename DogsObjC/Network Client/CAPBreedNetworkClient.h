//
//  CAPBreenNetworkClient.h
//  DogsObjC
//
//  Created by Lo Howard on 5/22/19.
//  Copyright © 2019 Lo Howard. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CAPDogs;
@class CAPDogSubBreed;

NS_ASSUME_NONNULL_BEGIN

@interface CAPBreedNetworkClient : NSObject

+(CAPBreedNetworkClient *)shared;

-(void) fetchAllBreeds:(void (^)(NSArray *))completion;

-(void) fetchBreedImageURLs:(CAPDogs *)breed completion:(void (^)(NSArray *))completion;

-(void) fetchSubBreedImageURLs:(CAPDogSubBreed *)subBreed breed:(CAPDogs *)breed completion:(void (^)(NSArray *))completion;

-(void) fetchImageData:(NSURL *)url completion:(void (^) (NSData *imageData, NSError *error))completion;


@end

NS_ASSUME_NONNULL_END
