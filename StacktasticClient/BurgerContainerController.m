//
//  BurgerContainerController.m
//  StacktasticClient
//
//  Created by Eric Mentele on 2/16/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import "BurgerContainerController.h"

@interface BurgerContainerController ()

@property (strong,nonatomic) UIViewController* topViewController;
@property (strong,nonatomic) UIButton* burgerButton;
@property (strong,nonatomic) UIGestureRecognizer* tapToClose;
@property (strong,nonatomic) UIPanGestureRecognizer* slideIt;

@end

@implementation BurgerContainerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  UINavigationController *searchVC = [self.storyboard instantiateViewControllerWithIdentifier:@"searchVC"];
  [self addChildViewController:searchVC];
  searchVC.view.frame = self.view.frame;
  [self.view addSubview:searchVC.view];
  [searchVC didMoveToParentViewController:self];
  
  UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(15, 15, 50, 50)];
  //[button setBackgroundImage forState:<#(UIControlState)#>]; //add image!
  UITapGestureRecognizer *tapClose = [UITapGestureRecognizer alloc] initWithTarget:self action:(_tapToClose);
  [button addTarget:self action:@selector(burgerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  [searchVC.view addSubview:button];
  self.tapToClose =[[UIGestureRecognizer alloc]init];
  self.slideIt = [[UIGestureRecognizer alloc]init];
  
}

-(void)burgerButtonPressed {
  
  self.burgerButton.userInteractionEnabled = false;
  
  __weak BurgerContainerController *weakSelf = self;
  
  [UIView animateWithDuration:.3 animations:^{
    weakSelf.topViewController.view.center = CGPointMake(weakSelf.topViewController.view.center.x + 250, weakSelf.topViewController.view.center.y);
  } completion:^(BOOL finished) {
    
    
  }];
  
}

-(void)tapToClose {
  
  __weak BurgerContainerController *weakSelf = self;
  
  [UIView animateWithDuration:0.3 animations:^{
    weakSelf.topViewController.view.center = weakSelf.view.center;
  } completion:^(BOOL finished) {
    weakSelf.burgerButton.userInteractionEnabled = true;
  }];
  
}


-(void)slidePanel{
  
  UIPanGestureRecognizer *pan = (UIPanGestureRecognizer*)sender;
  
  CGPoint translatedPoint = [pan translationInView:self.view];
  CGPoint velocity = [pan velocityInView:self.view];
  if ([pan state] == UIGestureRecognizerStateChanged) {
    
    if (velocity.x > 0 || self.topViewController.view.frame.origin.x > 0) {
    
    (self.topViewController.view.center.x + translatedPoint.x, self.topViewController.view.center.y);
    [pan setTranslation:CGPointZero inView:self.view];
  }
  }
  
  if ([pan state] == UIGestureRecognizerStateEnded) {
    
    if (self.topViewController.view.frame.origin.x > self.view.frame.size.width / 3) {
      NSLog(@"intentionally opened");
      self.burgerButton.userInteractionEnabled = false;
      __weak BurgerContainerController *weakSelf = self;
      [UIView animateWithDuration:0.3 animations:^{
        self.topViewController.view.center = CGPointMake(self.view.frame.size.width * 1.5, self.topViewController.view.center.y);} completion:^(BOOL finished) {
          [self.topViewController.view addGestureRecognizer:self.tapToClose];
       }];
    } else {
      [UIView animateWithDuration:0.2 animations:^{
        weakSelf.topViewController.view.center = weakSelf.view.center;
      }];
      
    }
    }
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
