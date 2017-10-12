//
//  ViewController.m
//  button-customVocal
//
//  Created by 张建 on 2017/3/20.
//  Copyright © 2017年 JuZiShu. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()
{
    
    SystemSoundID soundFileObject;
}
@property (nonatomic,strong)UIButton * btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = CGRectMake(100, 100, 100, 100);
    _btn.backgroundColor = [UIColor greenColor];
    _btn.layer.cornerRadius = 50;
    _btn.layer.masksToBounds = YES;
    [_btn setTitle:@"vocal" forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
    
}
- (void)btnClick:(UIButton *)btn{
    
    //得到音效文件的地址
    NSString * soundFilePath = [[NSBundle mainBundle] pathForResource:@"tabBarVocal" ofType:@"mp3"];
    
    //将地址转换成URL
    NSURL * soundURL = [NSURL fileURLWithPath:soundFilePath];
    
    //生成系统音效ID
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &soundFileObject);
    
    //播放系统音效
    AudioServicesPlaySystemSound(soundFileObject);
    
    //动效
    [self shakeToShow:btn];
    
}

#pragma mark - **************** 列表中按钮点击动画效果
-(void)shakeToShow:(UIButton *)button{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [button.layer addAnimation:animation forKey:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
