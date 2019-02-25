//
//  ViewController.m
//  RoundMenuDemo
//
//  Created by lv on 2019/2/12.
//  Copyright © 2019 lv. All rights reserved.
//

#import "ViewController.h"
 #import "RoundMenuView.h"


@interface ViewController ()<RoundMenuViewDelgegate>

@property (nonatomic,strong) RoundMenuView *roundMenu;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:@"Group Copy 7"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(self.view.bounds.size.width  - 110.0, self.view.bounds.size.height - 110.0, 80, 80);
//    btn.center = self.view.center;
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    _roundMenu = [[RoundMenuView alloc]initWithFrame:self.view.bounds];
    [_roundMenu addButtonTitle:@"健康计划" withImage:[UIImage imageNamed:@"Group 40"]];
    [_roundMenu addButtonTitle:@"HIIT" withImage:[UIImage imageNamed:@"Group 41"]];
    [_roundMenu addButtonTitle:@"跑步" withImage:[UIImage imageNamed:@"Group 40"]];
    [_roundMenu addButtonTitle:@"骑行" withImage:[UIImage imageNamed:@"Group 41"]];
    [_roundMenu addButtonTitle:@"肌肉" withImage:[UIImage imageNamed:@"Group 40"]];
    
    [_roundMenu setCenterBtnFrame:btn.frame];
    [_roundMenu setCenterBtnImage:[UIImage imageNamed:@"Group Copy 7"]];
    _roundMenu.delegate = self;
    
}


-(void)btnClicked{
    
    [_roundMenu showInParentView:self.view];
}

- (void)clickedButtonAtIndex:(NSInteger)index withTitle:(NSString *)title{
        NSLog(@"%ld   %@",index,title);
}

@end
