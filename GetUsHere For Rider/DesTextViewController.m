//
//  DesTextViewController.m
//  GetUsHere For Rider
//
//  Created by bharat on 14/09/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "DesTextViewController.h"
#import "MVPlaceSearchTextField.h"


static NSString * const KMapPlacesApiKey = @"AIzaSyAIyff4QNwE1x_0KZ7xVZhMQUMNX_VGEd4";
@interface DesTextViewController ()

@end

@implementation DesTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"Destination Location";
    self.view.backgroundColor = [UIColor colorWithRed:245.0/255.0f green:244.0/255.0f blue:244.0/255.0f alpha:1.0];
}


-(void)viewDidAppear:(BOOL)animated
{
    _searchDropAddRef.autoCompleteRegularFontName =  @"HelveticaNeue-Bold";
    
    _searchDropAddRef.autoCompleteBoldFontName = @"HelveticaNeue";
    
    _searchDropAddRef.autoCompleteTableCornerRadius=0.0;
    
    _searchDropAddRef.autoCompleteRowHeight=35;
    
    _searchDropAddRef.autoCompleteTableCellTextColor=[UIColor colorWithWhite:0.131 alpha:1.000];
    
    _searchDropAddRef.autoCompleteFontSize=14;
    
    _searchDropAddRef.autoCompleteTableBorderWidth=1.0;
    
    _searchDropAddRef.showTextFieldDropShadowWhenAutoCompleteTableIsOpen=YES;
    
    _searchDropAddRef.autoCompleteShouldHideOnSelection=YES;
    
    _searchDropAddRef.autoCompleteShouldHideClosingKeyboard=YES;
    
    _searchDropAddRef.autoCompleteShouldSelectOnExactMatchAutomatically = YES;
    
    _searchDropAddRef.autoCompleteTableFrame = CGRectMake((self.view.frame.size.width-_searchDropAddRef.frame.size.width)*0.01, _searchDropAddRef.frame.size.height+105.0, self.view.frame.size.width-0.1, 200.0);
}

#pragma mark - Place search Textfield Delegates

-(void)placeSearch:(MVPlaceSearchTextField*)textField ResponseForSelectedPlace:(GMSPlace*)responseDict
{
    [self.view endEditing:YES];
    
    // NSString *strdata=_searchDropAddRef.text;
    NSDictionary *date=[[NSDictionary alloc] initWithObjectsAndKeys:_searchDropAddRef.text,@"Data", nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"anynamedes" object:self userInfo:date];
    
     [self.navigationController popViewControllerAnimated:YES];
}



-(void)viewWillAppear:(BOOL)animated
{
    _searchDropAddRef.placeSearchDelegate                 = self;
    
    _searchDropAddRef.strApiKey                           = KMapPlacesApiKey;
    
    _searchDropAddRef.superViewOfList                     = self.view;  // View, on which Autocompletion list should be appeared.
    
    _searchDropAddRef.autoCompleteShouldHideOnSelection   = YES;
    
    _searchDropAddRef.maximumNumberOfAutoCompleteRows     = 5;
}


-(void)viewWillDisappear:(BOOL)animated
{
//    NSDictionary *date=[[NSDictionary alloc] initWithObjectsAndKeys:_searchDropAddRef.text,@"Data", nil];
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"anynamedes" object:self userInfo:date];
    
}

-(void)placeSearchWillShowResult:(MVPlaceSearchTextField*)textField
{
    
}

-(void)placeSearchWillHideResult:(MVPlaceSearchTextField*)textField
{
    
}

-(void)placeSearch:(MVPlaceSearchTextField*)textField ResultCell:(UITableViewCell*)cell withPlaceObject:(PlaceObject*)placeObject atIndex:(NSInteger)index
{
    
    if(index%2==0){
        
        cell.contentView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        
    }else{
        
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
