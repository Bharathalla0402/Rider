//
//  BookTaxiViewController.h
//  GetUsHere For Rider
//
//  Created by bharat on 18/02/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJSON.h"
#import "JSON.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MyAnnotation.h"
#import "MVPlaceSearchTextField.h"
#import "PickTextViewController.h"
@import GoogleMaps;



@interface BookTaxiViewController : UIViewController<GMSMapViewDelegate,PlaceSearchTextFieldDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate>
{
    CLLocationManager *locationManager;
    MKCoordinateRegion region;
    CLPlacemark *thePlacemark;
    CLPlacemark *thePlacemark1;
    MKRoute *routeDetails;
    
    int count;
    
    BOOL firstLocationUpdate_;
    GMSPanoramaView  *panoView_;
    GMSPolyline *polyPath;
    
    NSMutableData *receivedGeoData;
    
    IBOutlet UITableView *locationTbl;
    IBOutlet UITableView *locationTbl2;
    NSMutableArray *arrLocations;
    float			core_latitude;
    float			core_longitude;
    
    float			latitude;
    float			longitude;
    
    float			latitudet;
    float			longituden;
    
    float			latitude1;
    float			longitude1;
    
    
    int j,i,k,l,a,c,d,e,f,m,n,o,p,q;
    int cont;
    CLHeading *newHeading;
    CGFloat radians;
    
     NSArray* routes;
    
    NSArray *currentLocationAddArr;
    NSString *strProtiens,*strCalroies,*strfats,*strAdd,*strAdd1,*strCal;
    
    UIImageView *sampleimv,*sampleImgView,*sampleImgView1,*sampleImgView2,*sampleImgView3,*sampleImgView4,*sampleImgView5,*sampleImgView6,*sampleImgView7,*sampleImgView8,*sampleImgView9;
   
    
    CLLocation *pinlocation;
    
    UIButton *btnSelected;
    UIButton *button;
    
    UIImageView *markerimage;
    
    NSString *str1;
    NSString *str2;
    NSString *lat;
    NSString *log;
    NSString *strcurr;
    
    NSMutableArray *arrnearcardetails;
    NSMutableArray *arrlocationscarslat;
    NSMutableArray *arrlocationscarslog;
    NSMutableDictionary *arrlatlong;
    NSDictionary *dictionar;
    
    NSMutableDictionary *arrpointsoflalong;
    NSMutableArray *arrpointlat;
    NSMutableArray *arrpointlong;
    
    NSMutableArray *arrpointlat1,*arrpointlat2,*arrpointlat3,*arrpointlat4,*arrpointlat5,*arrpointlat6,*arrpointlat7,*arrpointlat8,*arrpointlat9;
    NSMutableArray *arrpointlong1,*arrpointlong2,*arrpointlong3,*arrpointlong4,*arrpointlong5,*arrpointlong6,*arrpointlong7,*arrpointlong8,*arrpointlong9;
    
    GMSMarker *marker1;
    GMSMarker *marker2;
    
    NSString *strgender;
}
@property BOOL isInternetConnectionAvailable;

@property (weak, nonatomic) IBOutlet UIButton *requestnowbutt;
@property (weak, nonatomic) IBOutlet UIButton *bookbutt;

@property (weak, nonatomic) IBOutlet UIView *viewcon;

@property (weak, nonatomic) IBOutlet GMSMapView *mapView_;


@property (weak, nonatomic) IBOutlet MVPlaceSearchTextField *searchDropAddRef;
@property (weak, nonatomic) IBOutlet MVPlaceSearchTextField *searchDropAddRef2;


@property(nonatomic,retain) NSString *catID;

@property (weak, nonatomic) IBOutlet UIButton *currentlocationbutt;



@end
