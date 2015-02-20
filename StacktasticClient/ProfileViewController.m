//
//  ProfileViewController.m
//  StacktasticClient
//
//  Created by Eric Mentele on 2/18/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//ARC DISABLED FOR THIS FILE

#import "ProfileViewController.h"

@interface ProfileViewController () <UIScrollViewDelegate>

@property (retain,nonatomic) UIScrollView *scrollView;
//@property (retain,nonatomic) UITextField *textField;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  //Manual scroll view and text field
//  self.scrollView                 = [[UIScrollView alloc]initWithFrame:self.view.frame];
//  self.scrollView.backgroundColor = [UIColor darkGrayColor];
 //self.scrollView.contentSize     = CGSizeMake(self.view.frame.size.width, 2000);
  //self.scrollView.pagingEnabled = true;
//  [self.view addSubview:self.scrollView];
//
//  UITextField *textField          = [[UITextField alloc] initWithFrame:CGRectMake(100, 1000, 100, 50)];
//  textField.backgroundColor       = [UIColor blueColor];
//  [self.scrollView addSubview:textField];
//  [textField release];
//  self.scrollView.delegate        = self;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
  NSLog(@"Scrolling, scrolling, scrolling..");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"MEMORY WARNING!!!!!!");
}


-(void)dealloc {
  
  //[self.scrollView release];
  [super dealloc];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
