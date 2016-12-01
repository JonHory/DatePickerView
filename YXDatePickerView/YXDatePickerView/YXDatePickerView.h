//
//  YXDataPickerView.h
//  YXDataPickerView
//
//  Created by Jonhory on 2016/12/1.
//  Copyright © 2016年 com.wujh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YXDataPickerViewDelegate <NSObject>

- (void)yxDatePickerViewDone:(NSString *)time timeInterval:(NSTimeInterval)timeInterVal;

@end

@interface YXDatePickerView : UIView

+ (instancetype)addToViewController:(UIViewController *)viewController;

/** 实现点击按钮代理*/
@property (nonatomic ,weak) id<YXDataPickerViewDelegate> delegate;

- (void)show;
- (void)hide;
- (BOOL)isHidden;

@end
