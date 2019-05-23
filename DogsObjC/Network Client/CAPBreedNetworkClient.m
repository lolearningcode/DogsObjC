//
//  CAPBreenNetworkClient.m
//  DogsObjC
//
//  Created by Lo Howard on 5/22/19.
//  Copyright © 2019 Lo Howard. All rights reserved.
//

#import "CAPBreedNetworkClient.h"
#import "CAPDogs.h"
#import "CAPDogSubBreed.h"

static NSString *const baseURLString = @"https://dog.ceo/api";

@implementation CAPBreedNetworkClient

+(instancetype)shared
{
    static CAPBreedNetworkClient *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [CAPBreedNetworkClient new];
    });
    return shared;
}

- (void)fetchAllBreeds:(void (^)(NSArray *))completion
{
    NSURL *url = [[NSURL alloc] initWithString:baseURLString];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil);
            return;
        }
        
        if (!data) {
            NSLog(@"Data is missing🤬🤬");
            completion(nil); return;
        }
        
        NSDictionary *topLevelJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if (!topLevelJSON || !([topLevelJSON isKindOfClass:[NSDictionary class]])) {
            NSLog(@"JSON not a dictionary class");
            completion(nil); return;
        }
        
        NSDictionary *dataDictionary = topLevelJSON[@"message"];
        NSMutableArray *arrayOfDogs = [[NSMutableArray alloc] init];
        for (id dogs in dataDictionary) {
            NSMutableArray *subBreeds = [[NSMutableArray alloc] init];
            for (NSString *name in dataDictionary[dogs]) {
                CAPDogSubBreed *subBreed = [[CAPDogSubBreed alloc] initWithName:name imageURLs:[[NSMutableArray alloc] init]];
                [subBreeds addObject:subBreed];
            }
            CAPDogs *breed = [[CAPDogs alloc] initWithTitle:dogs subBreeds:subBreeds imageURLs:[[NSMutableArray alloc] init]];
            [arrayOfDogs addObject:breed];
        }
        completion(arrayOfDogs);
    }] resume];
}

- (void)fetchBreedImageURLs:(CAPDogs *)breed completion:(void (^)(NSArray *))completion
{
    NSURL *url = [NSURL URLWithString:baseURLString];
    NSURL *fullURL = [[[url URLByAppendingPathComponent:@"breed"] URLByAppendingPathComponent:breed.name] URLByAppendingPathComponent:@"images"];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:fullURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil);
            return;
        }
        if (!data) {
            NSLog(@"Data Missing");
            completion(nil); return;
        }
        
        NSDictionary *imageDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (!imageDictionary || !([imageDictionary isKindOfClass:[NSDictionary class]])) {
            NSLog(@"JSON not a dictionary class");
            completion(nil); return;
        }
        NSMutableArray *images = imageDictionary[@"message"];
        completion(images);
    }] resume];
}

- (void)fetchSubBreedImageURLs:(CAPDogSubBreed *)subBreed breed:(CAPDogs *)breed completion:(void (^)(NSArray *))completion
{
    NSURL *url = [NSURL URLWithString:baseURLString];
    NSURL *fullURL = [[[[url URLByAppendingPathComponent:@"breed"] URLByAppendingPathComponent:subBreed.name] URLByAppendingPathComponent:breed.name] URLByAppendingPathComponent:@"images"];
    [[[NSURLSession sharedSession] dataTaskWithURL:fullURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil);
            return;
        }
        if (!data) {
            NSLog(@"Data Missing");
            completion(nil); return;
        }
        NSDictionary *imageDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (!imageDictionary || !([imageDictionary isKindOfClass:[NSDictionary class]])) {
            NSLog(@"JSON not a dictionary class");
            completion(nil); return;
        }
        NSMutableArray *images = imageDictionary[@"message"];
        completion(images);
    }] resume];
}

- (void)fetchImageData:(NSURL *)url completion:(void (^)(NSData *data, NSError *error))completion
{
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil, error);
            return;
        }
        if (!data) {
            NSLog(@"Data Missing");
            completion(nil, error); return;
        }
        completion(data, nil);
    }] resume];
}

@end
