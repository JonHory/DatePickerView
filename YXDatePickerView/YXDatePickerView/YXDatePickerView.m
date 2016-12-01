//
//  YXDataPickerView.m
//  YXDataPickerView
//
//  Created by Jonhory on 2016/12/1.
//  Copyright © 2016年 com.wujh. All rights reserved.
//

#import "YXDatePickerView.h"

#define kSCREEN [UIScreen mainScreen].bounds.size
#define SELFSIZE self.bounds.size
static CGFloat const TITLEHEIGHT = 50.0;
static CGFloat const TITLEBUTTONWIDTH = 75.0;
static CGFloat const kPickerViewHeight = 216;

@interface YXDatePickerView ()

@property (nonatomic ,strong) UIView   * titleBackgroundView;/**< 标题栏背景*/
@property (nonatomic ,strong) UIButton * cancelBtn;/**< 取消按钮*/
@property (nonatomic, strong) UIButton * sureBtn;/**< 完成按钮*/

@property (nonatomic ,strong) UIDatePicker  * datePickerView;/**< 选择器*/
@property (nonatomic ,assign) BOOL isHidden;

@end

@implementation YXDatePickerView

- (UIView *)titleBackgroundView{
    if (!_titleBackgroundView) {
        _titleBackgroundView = [[UIView alloc]initWithFrame:
                                CGRectMake(0, 0, SELFSIZE.width, TITLEHEIGHT)];
        _titleBackgroundView.backgroundColor = [UIColor whiteColor];
    }
    return _titleBackgroundView;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc]initWithFrame:
                      CGRectMake(0, 0, TITLEBUTTONWIDTH, TITLEHEIGHT)];
        [_cancelBtn setTitle:@"取消"
                    forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor blueColor]
                         forState:UIControlStateNormal];
        [_cancelBtn addTarget:self
                       action:@selector(cancelBtnClicked)
             forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc]initWithFrame:
                    CGRectMake(SELFSIZE.width - TITLEBUTTONWIDTH, 0, TITLEBUTTONWIDTH, TITLEHEIGHT)];
        [_sureBtn setTitle:@"完成"
                  forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor blueColor]
                       forState:UIControlStateNormal];
        [_sureBtn addTarget:self
                     action:@selector(sureBtnClicked)
           forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (UIDatePicker *)datePickerView{
    if (!_datePickerView) {
        _datePickerView = [[UIDatePicker alloc]initWithFrame:
                              CGRectMake(0, TITLEHEIGHT, SELFSIZE.width, kPickerViewHeight)];
        _datePickerView.backgroundColor = [UIColor colorWithRed:239/255.f
                                                             green:239/255.f
                                                              blue:244.0/255.f
                                                             alpha:1.0];
        _datePickerView.datePickerMode = UIDatePickerModeDateAndTime;
        _datePickerView.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        
        NSDate * date = [NSDate date];
        _datePickerView.minimumDate = date;
        _datePickerView.maximumDate = [NSDate dateWithTimeInterval:(12259200) sinceDate:[NSDate date]];
        [_datePickerView setDate:date animated:YES];
    }
    return _datePickerView;
}

+ (instancetype)addToViewController:(UIViewController *)viewController{
    YXDatePickerView * view = [[YXDatePickerView alloc]initWithFrame:CGRectMake(0, kSCREEN.height, kSCREEN.width, kPickerViewHeight+TITLEHEIGHT)];
//    view.userInteractionEnabled = YES;
    view.isHidden = YES;
    [viewController.view addSubview:view];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //加载地址数据源
        [self loadAddressData];
        //加载标题栏
        [self loadTitle];
        //加载选择器
        [self loadPickerView];
    }
    return self;
}

- (void)loadAddressData{
    
}

- (void)loadTitle{
    [self addSubview:self.titleBackgroundView];
    [self.titleBackgroundView addSubview:self.cancelBtn];
    [self.titleBackgroundView addSubview:self.sureBtn];
}

- (void)loadPickerView{
    [self addSubview:self.datePickerView];
}

- (void)sureBtnClicked{
    if (self.delegate && [self.delegate respondsToSelector:@selector(yxDatePickerViewDone:timeInterval:)]) {
        [self hide];
        [self.delegate yxDatePickerViewDone:[self timeDateformatter:[self.datePickerView.date timeIntervalSince1970]] timeInterval:[self.datePickerView.date timeIntervalSince1970]];
    }
}

- (void)cancelBtnClicked{
    [self hide];
}

- (void)show{
    self.isHidden = NO;
    [self animation];
}

- (void)hide{
    self.isHidden = YES;
    [self animation];
}

- (BOOL)isHidden{
    return _isHidden;
}

- (void)animation{
    self.userInteractionEnabled = YES;
    [UIView animateWithDuration:0.5 animations:^{
        [UIView beginAnimations:@"move" context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelegate:self];
        //改变它的frame的x,y的值
        if (!self.isHidden) {
            self.frame = CGRectMake(0, kSCREEN.height - kPickerViewHeight - TITLEHEIGHT, kSCREEN.width, kPickerViewHeight+TITLEHEIGHT);
        }
        else {
            self.frame=CGRectMake(0,kSCREEN.height , kSCREEN.width, kPickerViewHeight + TITLEHEIGHT);
        }
        [UIView commitAnimations];
    }];
}

- (NSString *)timeDateformatter:(NSTimeInterval)timeInterVal {
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    dateformatter.dateFormat = @"MM-dd HH:mm";
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterVal];
    return [dateformatter stringFromDate:date];
}



@end
