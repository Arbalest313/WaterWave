//
//  Waterwave.m
//  hulk
//
//  Created by huangyuan on 4/20/16.
//  Copyright © 2016 WangZhaoYun. All rights reserved.
//

#import "WaterWave.h"
@interface WaterWave ()
@property (nonatomic, assign)CGRect frame;
@property (nonatomic, assign)BOOL waveup;
@property (nonatomic, assign)CGFloat waveCurvePostion;
@property (nonatomic, assign)CGFloat waveSpeedPosition;

@end

@implementation WaterWave
- (id)initWithFrame:(CGRect)frame

{
    if (self = [super init]) {
        [self setup:frame];
    }
    return self;
}



- (void)setup:(CGRect)frame{
    self.frame = frame;
    self.waveCurvePostion = 1.5f;
    self.waveSpeedPosition = 0.1f;
    self.waveup = NO;
    self.waterCurveSlop = 180;
    self.waterSpeed = 0.1f;
    self.waterCurveMin = 1.f;
    self.waterCurveMax = 1.5f;
    [NSTimer scheduledTimerWithTimeInterval:.05 target:self selector:@selector(animateWave) userInfo:nil repeats:YES];
}

-(void)animateWave {

    self.waveCurvePostion += self.waveup? 0.01f : -0.01f;
    if (self.waveCurvePostion <= self.waterCurveMin) {
        self.waveup = YES;
    }else if (self.waveCurvePostion >= self.waterCurveMax){
        self.waveup = NO;
    }
    self.waveSpeedPosition += self.waterSpeed;
    
    [self createPath];
}

- (void)createPath {
    UIBezierPath * path = [[UIBezierPath alloc] init];
    CGFloat  waterLevel = (1 - (self.waterLevelY > 1.f? 1.f : self.waterLevelY)) * self.frame.size.height;
    CGFloat y = waterLevel;
    [path moveToPoint:CGPointMake(0, y)];
    path.lineWidth = 1;

    for (CGFloat x = 0; x <= self.frame.size.width; x++) {
        y = self.waveCurvePostion * sin(x/self.waterCurveSlop*M_PI + 4* self.waveSpeedPosition/M_PI) * 5 + waterLevel;
        [path addLineToPoint:CGPointMake(x, y)];
    }
    [path addLineToPoint:CGPointMake(self.frame.size.width, y)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(0, self.frame.size.height)];
    [path closePath];
    
    if ([self.waveDelegate respondsToSelector:@selector(wavePath:)]) {
        [self.waveDelegate wavePath:path];
    }
}

@end
