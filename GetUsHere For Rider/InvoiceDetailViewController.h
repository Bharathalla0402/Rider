//
//  InvoiceDetailViewController.h
//  GetUsHere For Rider
//
//  Created by bharat on 17/05/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvoiceDetailViewController : UIViewController<UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *arrinvoiceDetails;
    NSMutableArray *arrtollscount;
    
    NSMutableArray *arrairportcount;
    
    NSString *strtollsnumber;
    NSString *strmiles;
    
    NSString *strairportcoun;
    
    UIView *popview;
    UIView *footerview;
    
    int value1,value2,value3,value4,value5,value6,value7;
    int value8,value9;
    
    IBOutlet UITableView *tabl;
    
    UITableViewCell *cell;
}
@property BOOL isInternetConnectionAvailable;

@property (weak, nonatomic) IBOutlet UILabel *faredetailsView;
@property (weak, nonatomic) IBOutlet UILabel *faredetailslinelab;
@property (weak, nonatomic) IBOutlet UILabel *bookingdetailslab;
@property (weak, nonatomic) IBOutlet UILabel *bookingdetailslinelab;
@property (weak, nonatomic) IBOutlet UILabel *pickuplocationtitlelab;
@property (weak, nonatomic) IBOutlet UILabel *deslocationtitlelab;



@property (weak, nonatomic) IBOutlet UILabel *invoiceno;
@property (weak, nonatomic) IBOutlet UILabel *totaldistance;
@property (weak, nonatomic) IBOutlet UILabel *totalridetime;
@property (weak, nonatomic) IBOutlet UILabel *totalfare;
@property (weak, nonatomic) IBOutlet UILabel *basefare;
@property (weak, nonatomic) IBOutlet UILabel *ratemileslable;
@property (weak, nonatomic) IBOutlet UILabel *ratemilesamount;
@property (weak, nonatomic) IBOutlet UILabel *totaltollscountlable;
@property (weak, nonatomic) IBOutlet UILabel *totaltollsfare;

@property (weak, nonatomic) IBOutlet UILabel *tipamount;

@property (weak, nonatomic) IBOutlet UILabel *airportcountlable;
@property (weak, nonatomic) IBOutlet UILabel *airportfare;


@property (weak, nonatomic) IBOutlet UILabel *servicetax;
@property (weak, nonatomic) IBOutlet UILabel *pickuptime;
@property (weak, nonatomic) IBOutlet UILabel *pickupaddress;
@property (weak, nonatomic) IBOutlet UILabel *destime;
@property (weak, nonatomic) IBOutlet UILabel *desaddress;


@property (weak, nonatomic) IBOutlet UILabel *triptodriver;
@property (weak, nonatomic) IBOutlet UIView *tripamountView;
@property (weak, nonatomic) IBOutlet UILabel *dollerlable;
@property (weak, nonatomic) IBOutlet UILabel *amountlable;
@property (weak, nonatomic) IBOutlet UIButton *dolleramountbutt;

@property (weak, nonatomic) IBOutlet UILabel *waitingChargeLab;

@property (weak, nonatomic) IBOutlet UIButton *proceedtopaymentbutt;
@property (weak, nonatomic) IBOutlet UIButton *CuponCodeButt;


@property (weak, nonatomic) IBOutlet UILabel *BaseFareCrossLine;
@property (weak, nonatomic) IBOutlet UILabel *MilesFareCrossLine;

@property (weak, nonatomic) IBOutlet UILabel *DiscountPricelab;

@end
