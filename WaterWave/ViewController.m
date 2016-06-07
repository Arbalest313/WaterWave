//
//  ViewController.m
//  WaterWave
//
//  Created by huangyuan on 4/28/16.
//  Copyright © 2016 com.hy.WaterWave. All rights reserved.
//

#import "ViewController.h"
#import "WaterWave.h"

#define kSCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
#define kFitW(oWidth) (oWidth)*kSCREEN_WIDTH/375.0

@interface ViewController () <HYWavePathDelegate>
@property (nonatomic, strong) WaterWave   * wave;
@property (nonatomic, strong) UIImageView * base;
@property (nonatomic, strong) UIImageView * fade;
@property (nonatomic, assign) CGFloat waterY ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self base];
    [self fade];
    [self wave].waterLevelY = 0.4;
    self.wave.waterCurveSlop = 180;
    self.wave.waterSpeed = 0.1;
    
}


#pragma mark - HYWavePathDelegate

-(void)wavePath:(UIBezierPath *)path {
    CAShapeLayer * maskLayer = [CAShapeLayer new];
    maskLayer.path = path.CGPath;
    self.fade.layer.mask = maskLayer;
    if (self.wave.waterLevelY >= 0.7) {
        self.waterY = -.0005f;
    }else if (self.wave.waterLevelY <= 0.4){
        self.waterY = .0005f;

    }
    [self wave].waterLevelY += self.waterY;

    
}

#pragma mark - getter && setter

- (WaterWave *)wave{
    if (!_wave) {
        _wave = [[WaterWave alloc] initWithFrame:self.fade.frame];
        _wave.waveDelegate = self;
    }
    return _wave;
}

- (UIImageView *)base{
    if (!_base) {
        _base = [[UIImageView alloc] initWithFrame:CGRectZero];
        _base.image = [UIImage imageNamed:@"base"];
        _base.frame = CGRectMake(kFitW(100), 64 + kFitW(150), kSCREEN_WIDTH - kFitW(200),kSCREEN_WIDTH - kFitW(200) * _base.image.size.height/ _base.image.size.width );
        [self.view addSubview:_base];
    }
    return _base;
}

- (UIImageView *)fade{
    if (!_fade) {
        _fade = [[UIImageView alloc] initWithFrame:CGRectZero];
        _fade.image = [UIImage imageNamed:@"fade"];
        _fade.frame = self.base.frame;
        [self.view addSubview:_fade];
    }
    return _fade;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
