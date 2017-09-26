//
//  FarecarselectViewController.m
//  GetUsHere For Rider
//
//  Created by bharat on 01/03/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "FarecarselectViewController.h"
#import "TableViewCell2.h"
#import "SWRevealViewController.h"
#import "BookTaxiViewController.h"
#import "DejalActivityView.h"
#import "FareEstimateViewController.h"
#import "SidebarViewController.h"
#import "GetUsHere.pch"
#import "SplachscreenViewController.h"


@interface FarecarselectViewController ()

@end

@implementation FarecarselectViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  //  [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    arrnames=[[NSMutableArray alloc]init];
    arrnames=[[NSUserDefaults standardUserDefaults]objectForKey:@"cars"];
    
    arrid=[[NSMutableArray alloc]init];
    arrid=[[NSUserDefaults standardUserDefaults]objectForKey:@"id"];
    
    arrcarnames=[[NSMutableArray alloc]init];
    arrcarrate=[[NSMutableArray alloc]init];
    arrcarid=[[NSMutableArray alloc]init];
    
    self.navigationItem.title=@"Select Cab Type";
     self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    //    arrnames=[[NSMutableArray alloc]initWithObjects:@"Toyata cars",@"Acura cars",@"Nissan cars",@"Chevy cars", nil];
    arrcars=[[NSMutableArray alloc]initWithObjects:@"car.png",@"car.png",@"car.png",@"car.png", nil];
    arrindex=[[NSMutableArray alloc]initWithObjects:@"arrow.png",@"arrow.png",@"arrow.png",@"arrow.png", nil];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrnames.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
    //  UITableViewCell *cell=[[UITableViewCell alloc]init];
    //       cell.textLabel.text=[arrnames objectAtIndex:indexPath.row];
    //    return cell;
    
    static NSString *CellClassName = @"TableViewCell2";
    
    TableViewCell2 *cell = (TableViewCell2 *)[tableView dequeueReusableCellWithIdentifier: CellClassName];
    
    if (cell == nil)
    {
        cell = [[TableViewCell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellClassName];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableViewCell2"
                                                     owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
        
    }
    
    UILabel *lblName=(UILabel *)[cell viewWithTag:2];
    UIImageView *image=(UIImageView*)[cell viewWithTag:1];
    UIImageView *imaged=(UIImageView*)[cell viewWithTag:3];
    
    lblName.text=[arrnames objectAtIndex:indexPath.row];
    NSString *imageName=[arrcars objectAtIndex:indexPath.row];
    NSString *imageNamed=[arrindex objectAtIndex:indexPath.row];
    image.image=[UIImage imageNamed:imageName];
    imaged.image=[UIImage imageNamed:imageNamed];
    
    
    return cell;
    
}- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FareEstimateViewController *bookTax=[self.storyboard instantiateViewControllerWithIdentifier:@"FareEstimateViewController"];
    bookTax.catID=[arrid objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:bookTax animated:YES];
}


-(void)PostdateToServerwithParameters:(NSMutableString *)parameters andApiExtension:(NSString *)ext
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,ext]]];
    request.HTTPMethod = @"POST";
    request.HTTPBody  = [parameters dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                                   [DejalBezelActivityView removeViewAnimated:YES];
                               } else {
                                   [self parseJSONResponse:data];
                                   [DejalBezelActivityView removeViewAnimated:YES];
                               }
                           }];
    
    
}

-(void)parseJSONResponse:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
    
    
 //   NSLog(@"*****Cars types ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    
    arrcarnames=[[responseJSON valueForKey:@"data"]valueForKey:@"name"];
    arrcarrate=[[responseJSON valueForKey:@"data"]valueForKey:@"rate"];
    arrcarid=[[responseJSON valueForKey:@"data"]valueForKey:@"id"];
    
    [[NSUserDefaults standardUserDefaults]setObject:arrcarnames forKey:@"cars"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:arrcarrate forKey:@"rate"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:arrcarid forKey:@"id"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    // NSLog(@"%@",DataArray);
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        
        //[self performSegueWithIdentifier:@"book" sender:self];
        
    }
    
    
}


- (IBAction)sidebarButton:(id)sender
{
    
    [self.revealViewController revealToggle:sender];
    
    
}

- (IBAction)CancelClicked:(id)sender
{
    SidebarViewController *bookTax=[self.storyboard instantiateViewControllerWithIdentifier:@"SidebarViewController"];
    [self.navigationController pushViewController:bookTax animated:YES];

}
-(void)viewDidDisappear:(BOOL)animated{
    
    self.title = @"";
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"Select Cab Type";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,logincheck]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    [profile appendString:[NSString stringWithFormat:@"&device_id=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"devicetoken"]]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONRdevicecheck:data];
                               }
                           }];
    
    
    
}


-(void)parseJSONRdevicecheck:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
  //  NSLog(@"***** login check details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        //        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        //
        //        [alert show];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Login"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        SplachscreenViewController *edit = [self.storyboard instantiateViewControllerWithIdentifier:@"SplachscreenViewController"];
        UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
        [navController setViewControllers: @[edit] animated: NO ];
        [self.revealViewController setFrontViewController:navController animated:YES];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        
        
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
