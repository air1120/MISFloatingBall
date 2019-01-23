//
//  AllFloatViewManager.m
//  MISFloatingBall
//
//  Created by Rason on 2019/1/23.
//  Copyright © 2019年 Mistletoe. All rights reserved.
//

#import "AllFloatViewManager.h"
#import "MISFloatingBall.h"
@implementation AllFloatViewManager
static MISFloatingBall *floating;
+ (void)show:(UIView *)floatView{
    if (!floating) {
        floating = [[MISFloatingBall alloc] initWithFrame:CGRectMake(100, 100, 60, 60)];
        // 自动靠边
        floating.autoCloseEdge = YES;
        floating.edgePolicy = MISFloatingBallEdgePolicyLeftRight;
        [floating setContent:[UIImage imageNamed:@"apple"] contentType:MISFloatingBallContentTypeImage];
        [floating visible];
        
        floating.clickHandler = ^(MISFloatingBall * _Nonnull floatingBall) {
            [floatingBall.parentView addSubview:floatView];
            
            floatView.hidden = !floatView.hidden;
            if(floatView.hidden==false){
                CGPoint point = floatingBall.center;
                if (point.x<=[UIScreen mainScreen].bounds.size.width/2) {
                    point.x = floatingBall.frame.size.width/2 + 8 + floatView.frame.size.width;
                }else{
                    point.x = [UIScreen mainScreen].bounds.size.width - floatingBall.frame.size.width - 8 -floatView.frame.size.width/2;
                }
                
                floatView.center = point;
                floatingBall.backgroundViewClickHandler  = ^(MISFloatingBall * _Nonnull floatingBall) {
                    floatingBall.clickHandler(floatingBall);
                };
            }else{
                floatingBall.backgroundViewClickHandler = NULL;
            }
            
        };
        floating.panStartHandler = ^(MISFloatingBall * _Nonnull floatingBall) {
            //        [floatingBall hide];
            floatView.hidden = YES;
        };
    }
    floating.hidden = false;
}
+ (void)hide{
    floating.hidden = true;
}
@end
