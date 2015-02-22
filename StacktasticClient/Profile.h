//
//  Profile.h
//  StacktasticClient
//
//  Created by Eric Mentele on 2/18/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Profile : NSObject

+(NSArray *)profileFromJSON:(NSData *)jsonData;

@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *avatarURL;
@property (strong,nonatomic) UIImage  *image;

@end
