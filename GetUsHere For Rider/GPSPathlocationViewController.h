//
//  GPSPathlocationViewController.h
//  GetUsHere For Rider
//
//  Created by bharat on 21/06/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@import GoogleMaps;

@interface GPSPathlocationViewController : UIViewController<GMSMapViewDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    float			latitude,latitude1,latitude2;
    float			longitude,longitude1,longitude2;
    
    GMSMarker *marker,*marker1;
    
    NSMutableArray *arrpointlat;
    NSMutableArray *arrpointlong;
    
    UIImageView *sampleImgView;
    
    NSMutableArray *arrdriverdetails;
    
    CLLocation *prevCurrLocation, *currLocation;
    NSArray *temp;
    
    int j,count;
    NSMutableArray *arrpointlat5;
    NSMutableArray *arrpointlong5;
}

@property (weak, nonatomic) IBOutlet GMSMapView *mapView_;
@property BOOL isInternetConnectionAvailable;
@end
