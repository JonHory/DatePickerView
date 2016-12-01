//
//  ViewController.m
//  YXDatePickerView
//
//  Created by Jonhory on 2016/12/1.
//  Copyright © 2016年 com.wujh. All rights reserved.
//

#import "ViewController.h"
#import "YXDatePickerView.h"

#define SCREEN [UIScreen mainScreen].bounds.size

@interface ViewController ()<YXDataPickerViewDelegate>

@property (nonatomic ,strong) YXDatePickerView * dateView;

@property (nonatomic ,strong) UILabel * timeLabel;

@end

@implementation ViewController

- (YXDatePickerView *)dateView{
    if (!_dateView) {
        _dateView = [YXDatePickerView addToViewController:self];
        _dateView.delegate = self;
    }
    return _dateView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, SCREEN.width, 50)];
    self.timeLabel.textAlignment = 1;
    [self.view addSubview:self.timeLabel];
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 50, 100, 50)];
    btn.center = CGPointMake(SCREEN.width/2, btn.center.y);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
   
}

- (void)btnC:(UIButton *)btn{
    if ([self.dateView isHidden]) {
        [self.dateView show];
    }else{
        [self.dateView hide];
    }
}

- (void)yxDatePickerViewDone:(NSString *)time timeInterval:(NSTimeInterval)timeInterVal{
    self.timeLabel.text = time;
    NSLog(@"%f",timeInterVal);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.dateView hide];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
