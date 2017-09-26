//
//  PickTextViewController.m
//  GetUsHere For Rider
//
//  Created by bharat on 14/09/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "PickTextViewController.h"
#import "MVPlaceSearchTextField.h"


static NSString * const KMapPlacesApiKey = @"AIzaSyAIyff4QNwE1x_0KZ7xVZhMQUMNX_VGEd4";
@interface PickTextViewController ()

@end

@implementation PickTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"PickUp Location";
    self.view.backgroundColor = [UIColor colorWithRed:245.0/255.0f green:244.0/255.0f blue:244.0/255.0f alpha:1.0];
}


-(void)viewDidAppear:(BOOL)animated
{
    _searchDropRef.autoCompleteRegularFontName =  @"HelveticaNeue-Bold";
    
    _searchDropRef.autoCompleteBoldFontName = @"HelveticaNeue";
    
    _searchDropRef.autoCompleteTableCornerRadius=0.0;
    
    _searchDropRef.autoCompleteRowHeight=35;
    
    _searchDropRef.autoCompleteTableCellTextColor=[UIColor colorWithWhite:0.131 alpha:1.000];
    
    _searchDropRef.autoCompleteFontSize=14;
    
    _searchDropRef.autoCompleteTableBorderWidth=1.0;
    
    _searchDropRef.showTextFieldDropShadowWhenAutoCompleteTableIsOpen=YES;
    
    _searchDropRef.autoCompleteShouldHideOnSelection=YES;
    
    _searchDropRef.autoCompleteShouldHideClosingKeyboard=YES;
    
    _searchDropRef.autoCompleteShouldSelectOnExactMatchAutomatically = YES;
    
    _searchDropRef.autoCompleteTableFrame = CGRectMake((self.view.frame.size.width-_searchDropRef.frame.size.width)*0.01, _searchDropRef.frame.size.height+105.0, self.view.frame.size.width-0.1, 200.0);
}

#pragma mark - Place search Textfield Delegates

-(void)placeSearch:(MVPlaceSearchTextField*)textField ResponseForSelectedPlace:(GMSPlace*)responseDict
{
    [self.view endEditing:YES];
    
   // NSString *strdata=_searchDropAddRef.text;
    NSDictionary *date=[[NSDictionary alloc] initWithObjectsAndKeys:_searchDropRef.text,@"Data", nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"anyname" object:self userInfo:date];
    
    [self.navigationController popViewControllerAnimated:YES];
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




-(void)viewWillAppear:(BOOL)animated
{
    _searchDropRef.placeSearchDelegate                 = self;
    
    _searchDropRef.strApiKey                           = KMapPlacesApiKey;
    
    _searchDropRef.superViewOfList                     = self.view;  // View, on which Autocompletion list should be appeared.
    
    _searchDropRef.autoCompleteShouldHideOnSelection   = YES;
    
    _searchDropRef.maximumNumberOfAutoCompleteRows     = 5;
    
}




-(void)viewWillDisappear:(BOOL)animated
{
//    NSDictionary *date=[[NSDictionary alloc] initWithObjectsAndKeys:_searchDropRef.text,@"Data", nil];
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"anyname" object:self userInfo:date];

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
