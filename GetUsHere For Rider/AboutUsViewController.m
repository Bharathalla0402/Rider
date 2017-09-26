//
//  AboutUsViewController.m
//  GetUsHere For Rider
//
//  Created by bharat on 11/03/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "AboutUsViewController.h"
#import "SidebarViewController.h"
#import "GetUsHere.pch"
#import "DejalActivityView.h"
#import "SplachscreenViewController.h"


@interface AboutUsViewController ()
{

    UIColor *selectedColor;
    UIView *view1;
    UIView *view2;
    UIView *view3;
    UIView *view4;
    
    UIImageView *image;
    UIImageView *image1;
    UIImageView *image2;
    UIImageView *image3;
    
    UILabel *lab;
    UILabel *lab1;
    UILabel *lab2;
    UILabel *lab3;

}

@end

@implementation AboutUsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title=@"About HOPPINRIDE";
    
    self.view.userInteractionEnabled=NO;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"b" style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(barButtonBackPressed:)];
    [backButton setImage:[UIImage imageNamed:@"Untitled-1-2.png"]];
    
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back.jpg"]];
    
    arrdetails=[[NSMutableArray alloc] init];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    view1=[[UIView alloc]initWithFrame:CGRectMake(0, 65, self.view.frame.size.width/4, 55)];
    view1.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    view1.layer.borderWidth=1;
    view1.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [self.view addSubview:view1];
    
    image=[[UIImageView alloc] initWithFrame:CGRectMake(view1.frame.size.width/2-12, 5, 24, 24)];
    image.image=[UIImage imageNamed:@"feedback-2.png"];
    [view1 addSubview:image];
    
    lab=[[UILabel alloc]initWithFrame:CGRectMake(view1.frame.size.width/2-30, 30, 60, 20)];
    lab.text=@"FeedBack";
    lab.textColor=[UIColor whiteColor];
    [lab setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [view1 addSubview:lab];
    
    UIButton *butt=[[UIButton alloc] initWithFrame:CGRectMake(1, 66, view1.frame.size.width-2, view1.frame.size.height-2)];
    butt.backgroundColor=[UIColor clearColor];
    [butt addTarget:self action:@selector(feedbackclicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:butt];
    
    
    
    
    view2=[[UIView alloc]initWithFrame:CGRectMake(view1.frame.size.width, 65, self.view.frame.size.width/4, 55)];
    view2.backgroundColor= [UIColor whiteColor];
    view2.layer.borderWidth=1;
    view2.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [self.view addSubview:view2];
    
    image1=[[UIImageView alloc] initWithFrame:CGRectMake(view2.frame.size.width/2-12, 5, 24, 24)];
    image1.image=[UIImage imageNamed:@"chat-4.png"];
    [view2 addSubview:image1];
    
    lab1=[[UILabel alloc]initWithFrame:CGRectMake(view1.frame.size.width/2-14, 30, 28, 20)];
    lab1.text=@"Chat";
    lab1.textColor=[UIColor blackColor];
    [lab1 setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [view2 addSubview:lab1];
    
    UIButton *butt2=[[UIButton alloc] initWithFrame:CGRectMake(view1.frame.size.width+1, 66, view2.frame.size.width-2, view2.frame.size.height-2)];
    butt2.backgroundColor=[UIColor clearColor];
    [butt2 addTarget:self action:@selector(ChatClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:butt2];
    
    
    
    view3=[[UIView alloc]initWithFrame:CGRectMake(view1.frame.size.width+view2.frame.size.width, 65, self.view.frame.size.width/4, 55)];
    view3.backgroundColor= [UIColor whiteColor];
    view3.layer.borderWidth=1;
    view3.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [self.view addSubview:view3];
    
    image2=[[UIImageView alloc] initWithFrame:CGRectMake(view1.frame.size.width/2-12, 5, 24, 24)];
    image2.image=[UIImage imageNamed:@"rt.png"];
    [view3 addSubview:image2];
    
    lab2=[[UILabel alloc]initWithFrame:CGRectMake(view3.frame.size.width/2-14, 30, 28, 20)];
    lab2.text=@"Rate";
    lab2.textColor=[UIColor blackColor];
    [lab2 setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [view3 addSubview:lab2];
    
    UIButton *butt3=[[UIButton alloc] initWithFrame:CGRectMake(view1.frame.size.width+view2.frame.size.width+1, 66, view3.frame.size.width-2, view3.frame.size.height-2)];
    butt3.backgroundColor=[UIColor clearColor];
    [butt3 addTarget:self action:@selector(RateClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:butt3];
    
    
    
    view4=[[UIView alloc]initWithFrame:CGRectMake(view1.frame.size.width+view2.frame.size.width+view3.frame.size.width, 65, self.view.frame.size.width/4, 55)];
    view4.backgroundColor= [UIColor whiteColor];
    view4.layer.borderWidth=1;
    view4.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [self.view addSubview:view4];
    
    image3=[[UIImageView alloc] initWithFrame:CGRectMake(view4.frame.size.width/2-12, 5, 24, 24)];
    image3.image=[UIImage imageNamed:@"map-3.png"];
    [view4 addSubview:image3];
    
    lab3=[[UILabel alloc]initWithFrame:CGRectMake(view4.frame.size.width/2-14, 30, 28, 20)];
    lab3.text=@"Map";
    lab3.textColor=[UIColor blackColor];
    [lab3 setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [view4 addSubview:lab3];
    
    UIButton *butt4=[[UIButton alloc] initWithFrame:CGRectMake(view1.frame.size.width+view2.frame.size.width+view3.frame.size.width+1, 66, view4.frame.size.width-2, view4.frame.size.height-2)];
    butt4.backgroundColor=[UIColor clearColor];
    [butt4 addTarget:self action:@selector(MapClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:butt4];
    
[self.revealViewController.view removeGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
    
     [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getpages]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONResponse:data];
                               }
                           }];

    _txtlbl.text=@"FeedBack:";
    _txtstr.hidden=YES;
}

-(void)parseJSONResponse:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
    NSLog(@"*****AboutUs details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        self.view.userInteractionEnabled=YES;
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        self.view.userInteractionEnabled=YES;
        arrdetails=[responseJSON valueForKey:@"data"];
        
        NSArray *arr1=[arrdetails objectAtIndex:0];
        
        NSString *urlString=[[NSString alloc]init];
        
        urlString = [arr1 valueForKey:@"description"];
        
     //   NSString *htmlString =[NSString stringWithFormat:@"<font-family = 'Helvetica Neue'>%@", urlString];
        
      NSString *htmlString = [NSString stringWithFormat:@"<span style=\"font-family: %@;\">%@</span>",
                      @"Helvetica Neue",
                      urlString];
        
        [_ContentView loadHTMLString:htmlString baseURL:nil];
    }
}


-(void)barButtonBackPressed:(id)sender
{
    SidebarViewController *side=[self.storyboard instantiateViewControllerWithIdentifier:@"SidebarViewController"];
    [self.navigationController pushViewController:side animated:YES];
}


- (IBAction)feedbackclicked:(id)sender
{
    
    view1.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    image.image=[UIImage imageNamed:@"feedback-2.png"];
    lab.textColor=[UIColor whiteColor];
    
    view2.backgroundColor= [UIColor whiteColor];
    image1.image=[UIImage imageNamed:@"chat-4.png"];
    lab1.textColor=[UIColor blackColor];
    
    view3.backgroundColor= [UIColor whiteColor];
    image2.image=[UIImage imageNamed:@"rt.png"];
    lab2.textColor=[UIColor blackColor];
    
    view4.backgroundColor= [UIColor whiteColor];
    image3.image=[UIImage imageNamed:@"map-3.png"];
    lab3.textColor=[UIColor blackColor];
    
    
    _txtlbl.text=@"FeedBack:";
    NSArray *arr1=[arrdetails objectAtIndex:0];
    
    NSString *urlString=[[NSString alloc]init];
    
    urlString = [arr1 valueForKey:@"description"];
    
    
    NSString *htmlString = [NSString stringWithFormat:@"<span style=\"font-family: %@; font-size: %i\">%@</span>",
                            @"Helvetica Neue",
                            14,
                            urlString];
    
    [_ContentView loadHTMLString:htmlString baseURL:nil];
    
}


- (IBAction)ChatClicked:(id)sender
{
    
    view1.backgroundColor= [UIColor whiteColor];
    image.image=[UIImage imageNamed:@"feedbackred.png"];
    lab.textColor=[UIColor blackColor];
    
    view2.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    image1.image=[UIImage imageNamed:@"whitechat.png"];
    lab1.textColor=[UIColor whiteColor];
    
    view3.backgroundColor= [UIColor whiteColor];
    image2.image=[UIImage imageNamed:@"rt.png"];
    lab2.textColor=[UIColor blackColor];
    
    view4.backgroundColor= [UIColor whiteColor];
    image3.image=[UIImage imageNamed:@"map-3.png"];
    lab3.textColor=[UIColor blackColor];
    
    _txtlbl.text=@"Chat:";
    
    NSArray *arr1=[arrdetails objectAtIndex:1];
    
    NSString *urlString=[[NSString alloc]init];
    
    urlString = [arr1 valueForKey:@"description"];
    
    
    NSString *htmlString = [NSString stringWithFormat:@"<span style=\"font-family: %@; font-size: %i\">%@</span>",
                            @"Helvetica Neue",
                            14,
                            urlString];
    
    [_ContentView loadHTMLString:htmlString baseURL:nil];
    
}


- (IBAction)RateClicked:(id)sender
{
    
    view1.backgroundColor= [UIColor whiteColor];
    image.image=[UIImage imageNamed:@"feedbackred.png"];
    lab.textColor=[UIColor blackColor];
    
    
    view2.backgroundColor= [UIColor whiteColor];
    image1.image=[UIImage imageNamed:@"chat-4.png"];
    lab1.textColor=[UIColor blackColor];
    
    view3.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    image2.image=[UIImage imageNamed:@"ratewhite.png"];
    lab2.textColor=[UIColor whiteColor];
    
    view4.backgroundColor= [UIColor whiteColor];
    image3.image=[UIImage imageNamed:@"map-3.png"];
    lab3.textColor=[UIColor blackColor];
    
    _txtlbl.text=@"Rate:";
    
    NSArray *arr1=[arrdetails objectAtIndex:2];
    
    NSString *urlString=[[NSString alloc]init];
    
    urlString = [arr1 valueForKey:@"description"];
    
    
    NSString *htmlString = [NSString stringWithFormat:@"<span style=\"font-family: %@; font-size: %i\">%@</span>",
                            @"Helvetica Neue",
                            14,
                            urlString];
    
    [_ContentView loadHTMLString:htmlString baseURL:nil];
}


- (IBAction)MapClicked:(id)sender
{
    view1.backgroundColor= [UIColor whiteColor];
    image.image=[UIImage imageNamed:@"feedbackred.png"];
    lab.textColor=[UIColor blackColor];
    
    
    view2.backgroundColor= [UIColor whiteColor];
    image1.image=[UIImage imageNamed:@"chat-4.png"];
    lab1.textColor=[UIColor blackColor];
    
    view3.backgroundColor= [UIColor whiteColor];
    image2.image=[UIImage imageNamed:@"rt.png"];
    lab2.textColor=[UIColor blackColor];
    
    view4.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    image3.image=[UIImage imageNamed:@"mapwhite.png"];
    lab3.textColor=[UIColor whiteColor];
    
    _txtlbl.text=@"Map:";
    
    NSArray *arr1=[arrdetails objectAtIndex:3];
    
    NSString *urlString=[[NSString alloc]init];
    
    urlString = [arr1 valueForKey:@"description"];
    
    
    NSString *htmlString = [NSString stringWithFormat:@"<span style=\"font-family: %@; font-size: %i\">%@</span>",
                            @"Helvetica Neue",
                            14,
                            urlString];
    
    [_ContentView loadHTMLString:htmlString baseURL:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
     [self.revealViewController.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    
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
    
    NSLog(@"***** login check details ******* %@", responseJSON);
    
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
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
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
