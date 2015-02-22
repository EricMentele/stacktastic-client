//
//  Profile.m
//  StacktasticClient
//
//  Created by Eric Mentele on 2/18/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import "Profile.h"

@implementation Profile

+(NSArray *)profileFromJSON:(NSData *)jsonData {
  
  NSError *error;
  NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
  if (error) {
    
    NSLog(@"%@",error.localizedDescription);
    return nil;
  }
  NSArray *items               = [jsonDictionary objectForKey:@"items"];
  NSMutableArray *temp         = [[NSMutableArray alloc] init];
  for (NSDictionary *item in items) {
    
    Profile *profile           = [[Profile alloc] init];
    profile.name               = item[@"display_name"];
    profile.avatarURL          = item[@"profile_image"];
    [temp addObject:profile];
  }
  NSArray *final               = [[NSArray alloc] initWithArray:temp];
  NSLog(@"%@",final);
  return final;
}

@end
