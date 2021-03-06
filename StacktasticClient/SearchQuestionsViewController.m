//
//  SearchQuestionsViewController.m
//  StacktasticClient
//
//  Created by Eric Mentele on 2/17/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import "SearchQuestionsViewController.h"
#import "StackOverflowService.h"
#import "Question.h"
#import "QuestionCell.h"

@interface SearchQuestionsViewController () <UISearchBarDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong,nonatomic) NSArray *questions;

@end

@implementation SearchQuestionsViewController

- (void)viewDidLoad {
  
  [super viewDidLoad];
  self.searchBar.delegate        = self;
  self.tableView.dataSource      = self;
  self.tableView.rowHeight       = UITableViewAutomaticDimension;
  // Do any additional setup after loading the view.
}//view did load


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  
  [[StackOverflowService sharedService] fetchQuestionsWithSearchTerm:searchBar.text completionHandler:^(NSArray *results, NSString *error) {
    
    self.questions                 = results;
    if (error) {
      
      UIAlertView *networkIssueAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:error delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
      [networkIssueAlert show];
    }//if error
    [self.tableView reloadData];
  }];//fetch question with search term
}//search bar button clicked


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  return self.questions.count;
}//number of rows in section


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  QuestionCell *cell             = [tableView dequeueReusableCellWithIdentifier:@"questionCell"forIndexPath:indexPath];
  cell.avatarImageView.image     = nil;
  Question *question             = self.questions[indexPath.row];
  cell.titleTextView.text        = question.title;
  
  if (!question.image) {
    
    [[StackOverflowService sharedService] fetchUserImage:question.avatarURL completionHandler:^(UIImage *image) {
      
      question.image                 = image;
      cell.avatarImageView.image     = image;
    }];
  } else {
    
    cell.avatarImageView.image     = question.image;
  }//if else
  return cell;
}//cell for row at index path

@end
