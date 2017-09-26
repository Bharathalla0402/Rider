//
//  GPSViewController.h
//  GetUsHere For Rider
//
//  Created by bharat on 05/05/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@import GoogleMaps;


@interface GPSViewController : UIViewController<GMSMapViewDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    float			latitude;
    float			longitude;
    
    GMSMarker *marker,*marker1;
    
    NSMutableArray *arrpointlat;
    NSMutableArray *arrpointlong;
    
    UIImageView *sampleImgView;
    
    NSMutableArray *arrdriverdetails;
    
    CLLocation *prevCurrLocation, *currLocation;
    NSArray *temp;
    
    int j,count;
}
@property (weak, nonatomic) IBOutlet GMSMapView *mapView_;
@property BOOL isInternetConnectionAvailable;
@end
