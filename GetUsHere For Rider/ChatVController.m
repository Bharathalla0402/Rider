//
//  ChatVController.m
//  GetUsHere For Rider
//
//  Created by bharat on 05/05/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "ChatVController.h"
#import "Customcell4.h"
#import "Customcell5.h"
#import "GetUsHere.pch"
#import "DejalActivityView.h"
#import "SplachscreenViewController.h"


@interface ChatVController ()
{
    Customcell4 *cell;
}
@end

@implementation ChatVController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"Chat";
    
    _TextMessage.delegate=self;
    
    arrmessage=[[NSMutableArray alloc]init];
    arrids=[[NSMutableArray alloc]init];
    arrimage=[[NSMutableArray alloc]initWithObjects:@"green.png",@"white.png", nil];
    tripdriverinfo=[[NSMutableArray alloc]init];
    
    self.ChatTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.ChatTable.backgroundColor=[UIColor lightGrayColor];
    
    tripdriverinfo=[[NSUserDefaults standardUserDefaults]objectForKey:@"driverinfo"];
    
    userid=[[NSUserDefaults standardUserDefaults]objectForKey:@"rid"];
    driverid=[NSString stringWithFormat:@"%@",[tripdriverinfo valueForKey:@"user_id"]];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   
                                   initWithTarget:self
                                   
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(method) object:nil];
    [self performSelector:@selector(method) withObject:nil afterDelay:0.1];
}


-(void)method
{

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,allmessage]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"receiver_id=%@",driverid]];
    [profile appendString:[NSString stringWithFormat:@"&sender_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid"]]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONR1:data];
                               }
                           }];

}


- (IBAction)ButtonClicked:(id)sender
{
    if (_TextMessage.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please Enter any Message" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
    [self.view endEditing:YES];
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,sendNewMessage]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"sender_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    [profile appendString:[NSString stringWithFormat:@"&receiver_id=%@",driverid]];
    [profile appendString:[NSString stringWithFormat:@"&message=%@",_TextMessage.text]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   _TextMessage.text=@"";
                                   [self parseJSONR:data];
                               }
                           }];
    }
}


-(void)parseJSONR:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
  //  NSLog(@"*****Near Driver details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        _TextMessage.text=@"";
       //  [self goToBottom];
    }
}

-(void)parseJSONR1:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
//    NSLog(@"*****Near Driver details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        
        arrmessage=[[[responseJSON valueForKey:@"data"]valueForKey:@"messages"]valueForKey:@"message"];
        arrids=[[responseJSON valueForKey:@"data"]valueForKey:@"messages"];
      
        [_ChatTable reloadData];
        // [self goToBottom];
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(method2) object:nil];
        [self performSelector:@selector(method2) withObject:nil afterDelay:0.1];
    }
}


-(void)goToBottom
{
    NSIndexPath *lastIndexPath = [self lastIndexPath];
    
    [_ChatTable scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


-(NSIndexPath *)lastIndexPath
{
    NSInteger lastSectionIndex = MAX(0, [_ChatTable numberOfSections] - 1);
    NSInteger lastRowIndex = MAX(0, [_ChatTable numberOfRowsInSection:lastSectionIndex] - 1);
    return [NSIndexPath indexPathForRow:lastRowIndex inSection:lastSectionIndex];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrids.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *str=[NSString stringWithFormat:@"%@",[[arrids valueForKey:@"sender_id"]objectAtIndex:indexPath.row]];
    
    if ([str isEqualToString:[[NSUserDefaults standardUserDefaults]objectForKey:@"rid"]])
    {
         static NSString *CellClassName = @"Customcell4";
        cell = (Customcell4 *)[tableView dequeueReusableCellWithIdentifier: CellClassName];
        
        if (cell == nil)
        {
            cell = [[Customcell4 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellClassName];
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Customcell4"
                                                         owner:self options:nil];
            cell = [nib objectAtIndex:0];
            self.ChatTable.separatorStyle = UITableViewCellSeparatorStyleNone;
            
            cell.backgroundColor = self.ChatTable.backgroundColor;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        UILabel *label1=(UILabel *)[cell viewWithTag:1];
        UILabel *label2=(UILabel *)[cell viewWithTag:4];
        
        NSArray *arr=[arrids objectAtIndex:indexPath.row];
        
        UIImageView *image=(UIImageView*)[cell viewWithTag:3];
        NSString *imageName=[arrimage objectAtIndex:0];
        image.image=[UIImage imageNamed:imageName];
        
        label1.text=[arr valueForKey:@"message"];
        label2.text=[arr valueForKey:@"created"];
        
    }
    
   else if ([str isEqualToString:driverid])
    {
        static NSString *CellClassName = @"Customcell4";
        
        cell = (Customcell4 *)[tableView dequeueReusableCellWithIdentifier: CellClassName];
        
        if (cell == nil)
        {
            cell = [[Customcell4 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellClassName];
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Customcell4"
                                                         owner:self options:nil];
            cell = [nib objectAtIndex:0];
            self.ChatTable.separatorStyle = UITableViewCellSeparatorStyleNone;
            
            cell.backgroundColor = self.ChatTable.backgroundColor;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        UILabel *label1=(UILabel *)[cell viewWithTag:2];
        UILabel *label2=(UILabel *)[cell viewWithTag:5];
        
        NSArray *arr=[arrids objectAtIndex:indexPath.row];
        
        UIImageView *image=(UIImageView*)[cell viewWithTag:3];
        NSString *imageName=[arrimage objectAtIndex:1];
        image.image=[UIImage imageNamed:imageName];
        
        label1.text=[arr valueForKey:@"message"];
        label2.text=[arr valueForKey:@"created"];
        
        
    }
    return cell;
}



- (void)dismissKeyboard
{
    [_TextMessage resignFirstResponder];
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:TRUE];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y -250., self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:TRUE];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y +250., self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@"\n"])
    {
        [textField resignFirstResponder];
        return NO;
    }
    
    return YES;
}
-(void)method2
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,allmessage]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"receiver_id=%@",driverid]];
    [profile appendString:[NSString stringWithFormat:@"&sender_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONR5:data];
                               }
                           }];
    
}
-(void)parseJSONR5:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
 //   NSLog(@"*****Near Driver details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        
        arrmessage=[[[responseJSON valueForKey:@"data"]valueForKey:@"messages"]valueForKey:@"message"];
        arrids=[[responseJSON valueForKey:@"data"]valueForKey:@"messages"];
        
        [_ChatTable reloadData];
        
        
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(method2) object:nil];
        [self performSelector:@selector(method2) withObject:nil afterDelay:2.0];
    }
}


- (void)didReceiveMemoryWarning
{
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
