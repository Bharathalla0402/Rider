//
//  MVPopView.m
//  
//
//  Created by ximiao on 15/10/10.
//
//

#import "MVPopView.h"

@implementation MVPopView
-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    UIGestureRecognizer *rec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stopTap)];
    [self addGestureRecognizer:rec];
    return self;
}

-(void)showInView:(UIView*)view {
    [view addSubview:self];
    CGRect rect = self.frame;
    rect.origin.y = view.frame.size.height;
    self.frame = rect;
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGRect rect = self.frame;
        rect.origin.y = view.frame.size.height - rect.size.height;
        self.frame = rect;
    } completion:nil];
    
    
//    CGRect rect = self.frame;
//    rect.origin.y = view.frame.size.height - rect.size.height;
//    self.frame = rect;
//    
//    CABasicAnimation *animation = [[CABasicAnimation alloc] init];
//    animation.duration = 0.3f;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//    animation.keyPath = @"transform.translation.y";
//    animation.fromValue = [NSNumber numberWithFloat:self.frame.size.height];
//    animation.toValue = [NSNumber numberWithFloat:0.0f];
//    animation.byValue = [NSNumber numberWithFloat:self.frame.size.height * -1.0f];
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    animation.removedOnCompletion = YES;
//    [self.layer addAnimation:animation forKey:nil];

}
-(void)dismiss {

    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect rect = self.frame;
        rect.origin.y += rect.size.height;
        self.frame = rect;
    } completion:nil];
}
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {\
    [self removeFromSuperview];
}
-(void)stopTap {
    
}
@end
