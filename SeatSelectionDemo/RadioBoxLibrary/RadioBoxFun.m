//
//  RadioBoxFun.m
//  RadioBoxDemo
//
//  Created by 李晓璐 on 2017/12/28.
//  Copyright © 2017年 onmmc. All rights reserved.
//

#import "RadioBoxFun.h"
#import "UIButton+TTButton.h"
@interface RadioBoxFun()

@property(nonatomic, strong)NSMutableArray *buttonArray;
@property(nonatomic, strong)UIView *superView;

@end

@implementation RadioBoxFun

-(void)radioBoxButtons:(NSArray *)buttonArray superView:(UIView *)superView defultSelectedInde:(NSInteger)index callBack:(void (^)(NSInteger selectIndex ,NSString *title))callBack{
    _superView = superView;
    _buttonArray = [NSMutableArray new];
    for (int i=0; i<buttonArray.count; i++) {
        UIButton *button = buttonArray[i];
        button.tag = i;
        if (index==i) {
            button.backgroundColor = [UIColor blueColor];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        [button addTapBlock:^(UIButton *btn) {
            [self clickedBtnWith:btn];
 
            callBack(btn.tag,btn.currentTitle);
        }];
        [superView addSubview:button];
        [_buttonArray addObject:button];
    }
}

-(void)clickedBtnWith:(UIButton *)btn{
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    for (int i=0; i<_buttonArray.count; i++) {
        UIButton *button = _buttonArray[i];
        if (button.tag!=btn.tag) {
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
}

-(UIButton *)creatButton:(CGRect)fram title:(NSString *)title{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;
    btn.frame = fram;
    return btn;
}

@end
