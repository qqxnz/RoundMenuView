//
//  RoundMenuView.h
//  RoundMenuDemo
//
//  Created by lv on 2019/2/12.
//  Copyright © 2019 lv. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RoundMenuViewDelgegate
-(void)clickedButtonAtIndex:(NSInteger)index withTitle:(NSString *)title;

@end

@interface RoundMenuView : UIView

@property (nonatomic,assign) id<RoundMenuViewDelgegate> delegate;

///设置中心按钮位置及大小
-(void)setCenterBtnFrame:(CGRect)frame;
///设置中心按钮图片
-(void)setCenterBtnImage:(UIImage *)image;
///添加按钮
-(void)addButtonTitle:(NSString *)title withImage:(UIImage *)image;
///显示 view = 父视图
-(void)showInParentView:(UIView *)view;

-(void)dismiss;
@end

NS_ASSUME_NONNULL_END
