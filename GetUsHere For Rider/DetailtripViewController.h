//
//  DetailtripViewController.h
//  GetUsHere For Rider
//
//  Created by bharat on 23/03/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MyAnnotation.h"

@interface DetailtripViewController : UIViewController<MKMapViewDelegate>
{
    NSMutableArray *arrdetails;
    UILabel *labid;
    NSArray *currentLocationAddArr;
    NSString *strProtiens,*strCalroies,*strfats,*strAdd,*strAdd1,*strCal;
    MKCoordinateRegion region;
    
    float			latitude;
    float			longitude;
    
    float			latitude1;
    float			longitude1;
    
}
@property(nonatomic, strong) IBOutlet MKMapView *mapView;
@property(nonatomic,retain) NSString *strpickup;
@property(nonatomic,retain) NSString *strDestination;
@property(nonatomic,retain) NSString *strdate;
@property(nonatomic,retain) NSString *strtime;
@property(nonatomic,retain) NSString *strstatus;
@property(nonatomic,retain) NSString *strtripid;

@property (weak, nonatomic) IBOutlet UILabel *lblpickup;
@property (weak, nonatomic) IBOutlet UILabel *lbldes;
@property (weak, nonatomic) IBOutlet UILabel *lbldate;
@property (weak, nonatomic) IBOutlet UILabel *lblstatus;

@property (nonatomic, retain) MKPolyline *routeLine; //your line
@property (nonatomic, retain) MKPolylineView *routeLineView; //overlay view

@end
