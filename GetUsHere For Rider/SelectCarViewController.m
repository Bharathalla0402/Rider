//
//  SelectCarViewController.m
//  GetUsHere For Rider
//
//  Created by bharat on 18/02/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "SelectCarViewController.h"
#import "TableViewCell2.h"
#import "SWRevealViewController.h"
#import "BookTaxiViewController.h"
#import "DejalActivityView.h"
#import "GetUsHere.pch"
#import "SidebarViewController.h"
#import "SplachscreenViewController.h"


@interface SelectCarViewController ()


@end

@implementation SelectCarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    arrnames=[[NSMutableArray alloc]init];
    arrnames=[[NSUserDefaults standardUserDefaults]objectForKey:@"cars"];
    
    arrid=[[NSMutableArray alloc]init];
    arrid=[[NSUserDefaults standardUserDefaults]objectForKey:@"id"];
    
    arrcarnames=[[NSMutableArray alloc]init];
    arrcarrate=[[NSMutableArray alloc]init];
    arrcarid=[[NSMutableArray alloc]init];
    
    self.navigationItem.title=@"Select Car Type";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"b" style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(barButtonBackPressed:)];
    [backButton setImage:[UIImage imageNamed:@"Untitled-1-2.png"]];
    
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
//    {
//        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
//    }
//    [self.revealViewController.view removeGestureRecognizer:self.revealViewController.panGestureRecognizer];

}

-(void)barButtonBackPressed:(id)sender
{
    
    SidebarViewController *side=[self.storyboard instantiateViewControllerWithIdentifier:@"SidebarViewController"];
    [self.navigationController pushViewController:side animated:YES];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrnames.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    
    lblName.text=[arrnames objectAtIndex:indexPath.row];

    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookTaxiViewController *bookTax=[self.storyboard instantiateViewControllerWithIdentifier:@"BookTaxiViewController"];
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
    
    }
}




-(void)viewDidAppear:(BOOL)animated
{
    
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//        self.navigationController.interactivePopGestureRecognizer.delegate = self;
//    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
//    {
//        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
//    }
//    [self.revealViewController.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;
}


-(void)viewDidDisappear:(BOOL)animated
{
    self.title = @"";
}


-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"Select Car Type";
    
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//        self.navigationController.interactivePopGestureRecognizer.delegate = self;
//    }
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
    
   // NSLog(@"***** login check details ******* %@", responseJSON);
    
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
