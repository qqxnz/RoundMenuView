//
//  RoundMenuView.m
//  RoundMenuDemo
//
//  Created by lv on 2019/2/12.
//  Copyright © 2019 lv. All rights reserved.
//

#import "RoundMenuView.h"

@interface RoundMenuView(){
    CGFloat offsetAngle;//偏移角度
    CGFloat angle;
    UIFont *font;
}

@property (nonatomic,strong) UIButton *centerBtn;
@property (nonatomic,strong) NSMutableArray *labArray;
@property (nonatomic,strong) NSMutableArray *btnArray;
@property (nonatomic,weak) UIView *parentView;

@end

@implementation RoundMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        offsetAngle = 180.0;
        angle = 30.0;///放五个按钮为90度/4=22.5度(第一个放到0所以不算。。。呜呜呜) 后改为4个按钮
        font = [UIFont fontWithName:@"PingFangSC-Regular" size: 14];
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.0];
        _centerBtn = [[UIButton alloc]init];
        [_centerBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_centerBtn];
        _btnArray = [[NSMutableArray alloc]init];
        _labArray = [[NSMutableArray alloc]init];
        
        UITapGestureRecognizer *tapGesturRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tapGesturRecognizer];

    }
    return self;
}

-(void)tapAction:(id)tap{
    [self dismiss];
}

-(void)setCenterBtnFrame:(CGRect)frame{
    _centerBtn.frame = frame;
}

-(void)setCenterBtnImage:(UIImage *)image{
    [_centerBtn setImage:image forState:UIControlStateNormal];
}

-(void)addButtonTitle:(NSString *)title withImage:(UIImage *)image{
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonsClicked:) forControlEvents:UIControlEventTouchUpInside];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
    longPress.minimumPressDuration = 0.5; //定义按的时间
    [btn addGestureRecognizer:longPress];
    UILabel * lab = [[UILabel alloc]init];
    lab.text = title;
    [lab setTextColor:[UIColor whiteColor]];
    lab.font = font;
    [self addSubview:btn];
    [self addSubview:lab];
    [_btnArray addObject:btn];
    [_labArray addObject:lab];
    
}
#pragma mark -
///按钮起始位置
-(void)btnsFrameInit{
    for (UIButton *btn in _btnArray) {
        btn.frame = CGRectMake(0, 0, 60, 60);
        btn.center = _centerBtn.center;
    }
    [self bringSubviewToFront:_centerBtn];
}

-(void)btnsShow{
    for(int i = 0 ; i < _btnArray.count ; i++){
        UIButton *btn = (UIButton *)_btnArray[i];
        btn.tag = i;
        CGFloat radian = (i * angle + offsetAngle) * M_PI / 180.0;
        CGFloat x = 120.0 * cosf(radian);
        CGFloat y = 120.0 * sinf(radian);
        btn.center = CGPointMake(_centerBtn.center.x + x, _centerBtn.center.y + y);
    }
    
}

-(void)btnsHidden{
    for(int i = 0 ; i < _btnArray.count ; i++){
        UIButton *btn = (UIButton *)_btnArray[i];
        btn.center = _centerBtn.center;
    }
    
}

-(void)buttonsClicked:(UIButton *)sender{
    NSString *title = @"";
    if(_labArray[sender.tag] != nil){
        UILabel *lab = (UILabel *)_labArray[sender.tag];
        title = lab.text;
    }
    [self.delegate clickedButtonAtIndex:sender.tag withTitle:title];
    [self dismiss];
}

-(void)btnLong:(UILongPressGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        NSString *title = @"";
        if(_labArray[gestureRecognizer.view.tag] != nil){
            UILabel *lab = (UILabel *)_labArray[gestureRecognizer.view.tag];
            title = lab.text;
        }
        [self.delegate longPressButtonAtIndex:gestureRecognizer.view.tag withTitle:title];
        [self dismiss];
    }
}

#pragma mark -
-(void)labsFrameInit{
    for (UILabel *lab in _labArray) {
        CGSize size = [self sizeWithText:lab.text withFont:font];
        lab.frame = CGRectMake(0, 0, size.width, size.height);
        [lab setHidden:YES];
    }
}
-(void)labsShow{
    for(int i = 0 ; i < _btnArray.count ; i++){
        UIButton *btn = (UIButton *)_btnArray[i];
        UILabel *lab = (UILabel *)_labArray[i];
        CGFloat radian = (i * angle + offsetAngle) * M_PI / 180.0;
        CGFloat x = lab.frame.size.width * cosf(radian);
        CGFloat y = lab.frame.size.height * sinf(radian);
        lab.frame = CGRectMake(btn.frame.origin.x + x + 8.0 , btn.frame.origin.y + y + 8.0, lab.frame.size.width, lab.frame.size.height);
        [lab setHidden:NO];
    }
}
-(void)labsHiidden{
    for (UILabel *lab in _labArray) {
        [lab setHidden:YES];
    }
}

#pragma mark -
-(void)showInParentView:(UIView *)view{
    if(view != nil){
        [self btnsFrameInit];
        [self labsFrameInit];
        _parentView = view;
        [_parentView addSubview:self];
        [UIView animateWithDuration:0.2 animations:^{
            self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
            [self btnsShow];
        } completion:^(BOOL finished) {
            [self labsShow];
        }];
        
    }
}


-(void)dismiss{
    [self labsHiidden];
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.0];
        [self btnsHidden];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}

#pragma mark -
/**
 
 计算单行文字的size
 
 @parms  文本
 
 @parms  字体
 
 @return  字体的CGSize
 
 */

-(CGSize)sizeWithText:(NSString *)text withFont:(UIFont *)font{
    
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:font}];
    
    return size;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
