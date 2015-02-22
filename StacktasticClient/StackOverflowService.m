//
//  StackOverflowService.m
//  StacktasticClient
//
//  Created by Eric Mentele on 2/17/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import "StackOverflowService.h"
#import "Question.h"
#import "Profile.h"

@implementation StackOverflowService


+(id)sharedService {
  
  static StackOverflowService *mySharedService;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    
    mySharedService                 = [[StackOverflowService alloc] init];
  });//dispatch once
  return mySharedService;
}//shared service singleton


//MARK: Get questions for search term==========================================================
-(void)fetchQuestionsWithSearchTerm:(NSString *)searchTerm completionHandler:(void (^)(NSArray *results, NSString *error))completionHandler {
  
  NSString *urlString             = @"https://api.stackexchange.com/2.2/";
  urlString                       = [urlString stringByAppendingString:@"search?order=desc&sort=activity&site=stackoverflow&intitle="];
  urlString                       = [urlString stringByAppendingString:searchTerm];
  NSUserDefaults *defaults        = [NSUserDefaults standardUserDefaults];
  NSString *token                 = [defaults objectForKey:@"token"];
  if (token) {
    
    urlString                       = [urlString stringByAppendingString:@"&access_token="];
    urlString                       = [urlString stringByAppendingString:token];
    urlString                       = [urlString stringByAppendingString:@"&key=Sx8sHgheFIjGHrkaG9eeJg(("];
  }//if token
  NSURL *url                      = [NSURL URLWithString:urlString];
  NSMutableURLRequest *request    = [[NSMutableURLRequest alloc] initWithURL:url];
  request.HTTPMethod              = @"GET";
  
  NSURLSession *session           = [NSURLSession sharedSession];
  
  NSURLSessionTask *dataTask      = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    
    if (error) {
      
      completionHandler(nil,@"Could not connect");
    } else {
      
      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
      NSInteger statusCode            = httpResponse.statusCode;
      
      switch (statusCode) {
          
        case 200 ... 299: {
          
          NSLog(@"%ld",(long)statusCode);
          NSArray *results                = [Question questionsFromJSON:data];
          
          dispatch_async(dispatch_get_main_queue(), ^{
            
            if (results) {
              
              completionHandler(results,nil);
            } else {
              
              completionHandler(nil,@"Search could not be completed");
            }//results
          });//main queue
          break;
        }//case 200..299
        default:
          NSLog(@"%ld",(long)statusCode);
          break;
      }//switch
    }//if else
  }];//data task
  [dataTask resume];
}//fetch questions with search term


//MARK: Get My User Info================================================
-(void)fetchMyUserInfo:(void (^)(NSArray *results, NSString *error))completionHandler {
  
  NSString *urlString             = @"https://api.stackexchange.com/2.2/me?order=desc&sort=reputation&site=stackoverflow";
  NSUserDefaults *defaults        = [NSUserDefaults standardUserDefaults];
  NSString *token                 = [defaults objectForKey:@"token"];
  if (token) {
    
    urlString                       = [urlString stringByAppendingString:@"&access_token="];
    urlString                       = [urlString stringByAppendingString:token];
    urlString                       = [urlString stringByAppendingString:@"&key=Sx8sHgheFIjGHrkaG9eeJg(("];
  }//if token
  NSURL *url                      = [NSURL URLWithString:urlString];
  NSMutableURLRequest *request    = [[NSMutableURLRequest alloc] initWithURL:url];
  request.HTTPMethod              = @"GET";
  NSLog(@"%@",url);
  
  NSURLSession *session           = [NSURLSession sharedSession];
  
  NSURLSessionTask *dataTask      = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    
    if (error) {
      
      completionHandler(nil,@"Could not connect");
    } else {
      
      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
      NSInteger statusCode            = httpResponse.statusCode;
      
      switch (statusCode) {
          
        case 200 ... 299: {
          
          NSLog(@"%ld",(long)statusCode);
          NSArray *results                = [Profile profileFromJSON:data];
          
          dispatch_async(dispatch_get_main_queue(), ^{
            
            if (results) {
              
              completionHandler(results,nil);
              //NSLog(@"%@",results,nil);
            } else {
              
              completionHandler(nil,@"Info could not be retrieved.");
            }//if else
          });//dispatch async main queue
          break;
        }//case 200-299
        default:
          NSLog(@"%ld",(long)statusCode);
          break;
      }//switch
    }//else
  }];//data task
  [dataTask resume];
}//fetch user info


//MARK: Get User Image==============================================
-(void)fetchUserImage:(NSString *)avatarURL completionHandler:(void (^) (UIImage *image))completionHandler {
  
  dispatch_queue_t imageQueue     = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0);
  dispatch_async(imageQueue, ^{
    
    NSURL *url                      = [NSURL URLWithString:avatarURL];
    NSData *data                    = [[NSData alloc] initWithContentsOfURL:url];
    UIImage *image                  = [UIImage imageWithData:data];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      
      completionHandler(image);
    });//main queue
  });//image queue
}//fetch user image

@end
