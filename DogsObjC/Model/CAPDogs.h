//
//  CAPDogs.h
//  DogsObjC
//
//  Created by Lo Howard on 5/22/19.
//  Copyright © 2019 Lo Howard. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CAPDogs : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSArray *subBreed;
@property (nonatomic, readonly) NSArray *imageURL;


-(instancetype)initWithTitle:(NSString *)name subBreed:(NSArray *)subBreed imageURL:(NSArray *)imageURL;

@end

NS_ASSUME_NONNULL_END
