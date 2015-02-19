//
//  MenuPressedDelegate.h
//  StacktasticClient
//
//  Created by Eric Mentele on 2/18/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MenuPressedDelegate <NSObject>

-(void)menuOptionSelected:(NSInteger)selectedRow;

@end

