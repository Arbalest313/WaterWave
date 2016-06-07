//
//  WaterWeave.h
//  hulk
//
//  Created by huangyuan on 4/20/16.
//  Copyright © 2016 WangZhaoYun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HYWavePathDelegate <NSObject>

- (void)wavePath:(UIBezierPath *)path;
@end


@interface WaterWave : NSObject
- (id)initWithFrame:(CGRect)frame;
/**
 *  0 to 1;
 */
@property(nonatomic, assign)CGFloat waterLevelY;

/**
 *  0 to 360 default = 180
 */
@property(nonatomic, assign)CGFloat waterCurveSlop;
/**
 *  default = 1.f
 */
@property(nonatomic, assign)CGFloat waterCurveMin;
/**
 *  default = 1.5f
 */
@property(nonatomic, assign)CGFloat waterCurveMax;
/**
 *  default = 0.1f
 */
@property(nonatomic, assign)CGFloat waterSpeed;


@property (nonatomic, weak) id<HYWavePathDelegate> waveDelegate;

@end
