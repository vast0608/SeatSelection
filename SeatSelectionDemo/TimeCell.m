//
//  TimeCell.m
//  SeatSelectionDemo
//
//  Created by 李晓璐 on 2018/11/3.
//  Copyright © 2018 LANEHUB. All rights reserved.
//

#import "TimeCell.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width

#define BUTTON_WIDTH (WIDTH-35)/4
#define BUTTON_HEIGHT (WIDTH-35)*2/17

#define buttonCount 12//button数量
@interface TimeCell ()

@property (nonatomic, strong) UIButton * btn;
@end

@implementation TimeCell
- (NSMutableArray *)selectMuArr{
    if (!_selectMuArr) {
        _selectMuArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _selectMuArr;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupContent];
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return self;
}

-(void)setupContent{
    //标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 50, 17)];
    titleLabel.text = @"时间";
    [self.contentView addSubview:titleLabel];
    //初始数据
    NSArray *titleArr =  @[
                           @[@"10:00",@"11:00",@"12:00",@"13:00"],
                           @[@"14:00",@"15:00",@"16:00",@"17:00"],
                           @[@"18:00",@"19:00",@"20:00",@"21:00"],
                           ];
    NSArray *titleSelectArr =  @[
                           @[@"10:00-11:00",@"11:00-12:00",@"12:00-13:00",@"13:00-14:00"],
                           @[@"14:00-15:00",@"15:00-16:00",@"16:00-17:00",@"17:00-18:00"],
                           @[@"18:00-19:00",@"19:00-20:00",@"20:00-21:00",@"21:00-22:00"],
                           ];
    //button布局
    for (int i = 0; i < 4; i++) {//i为列
        for (int j = 0; j < 3; j++) {//j为行
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.backgroundColor = [UIColor whiteColor];

            [btn setTitle:titleArr[j][i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [btn setTitle:titleSelectArr[j][i] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            btn.tag = (i + (4 * j)) + 100;
            [btn addTarget:self action:@selector(clickedBtnWith:) forControlEvents:UIControlEventTouchUpInside];
            btn.frame = CGRectMake(10 + i * (BUTTON_WIDTH + 5), 52 + j * (BUTTON_HEIGHT + 15), BUTTON_WIDTH, BUTTON_HEIGHT);
            btn.layer.cornerRadius = 3;
            btn.layer.masksToBounds = YES;
            [self.contentView addSubview:btn];
            
            _btn = btn;
        }
    }

    [self updateButtonStstusWidthIsDefaultSelect:YES unSelectIndexArr:@[@(2)]];
}


//更新button按钮的状态
-(void)updateButtonStstusWidthIsDefaultSelect:(BOOL)defaultSelect unSelectIndexArr:(NSArray *)unSelectIndexArr{

    //取所有button的下标放在数组中
    NSMutableArray *indexPathMuArr = [NSMutableArray new];
    for (int i=0; i<buttonCount; i++) {
        [indexPathMuArr addObject:@(i)];
    }
    //去除不可选的下标，剩下的都是可选的
    for (int i=0; i<indexPathMuArr.count; i++) {
        for (int j=0; j<unSelectIndexArr.count; j++) {
            if ([unSelectIndexArr[j] integerValue]==i) {
                [indexPathMuArr removeObject:@(i)];
            }
        }
    }
    //把可选的数组最小的下标赋值给默认选择的button的下标值
    NSInteger index;
    if (defaultSelect==YES) {//有默认选择的就给其赋值
        index = [indexPathMuArr[0] integerValue];
    }else{//没有则给一个超出界限的值，这样就不会显示了
        index = buttonCount;
    }
    
    
    for (int i=0; i<buttonCount; i++) {
        //根据button选择的状态恢复按钮颜色和字体
        UIButton *btns = [self.contentView viewWithTag:i + 100];
        if (btns.selected == YES) {
            [btns setBackgroundColor:[UIColor blueColor]];
            [btns setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            if (![self.selectMuArr containsObject:[NSNumber numberWithInteger:btns.tag - 100]]) {
                NSNumber *index = [NSNumber numberWithInteger:btns.tag - 100];
                [self.selectMuArr addObject:index];
            }
        }else{
            [btns setBackgroundColor:[UIColor whiteColor]];
            [btns setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            if ([self.selectMuArr containsObject:[NSNumber numberWithInteger:btns.tag - 100]]) {
                NSNumber *index = [NSNumber numberWithInteger:btns.tag - 100];
                [self.selectMuArr removeObject:index];
            }
        }
        
        //判断那个时不可选的
        UIButton *btnEnabledYES = [self.contentView viewWithTag:i + 100];
        [btnEnabledYES setBackgroundImage:nil forState:UIControlStateNormal];
        btnEnabledYES.enabled = YES;
        for (int j=0; j<unSelectIndexArr.count; j++) {
            if ([unSelectIndexArr[j] integerValue]==i) {
                UIButton *btnEnabledNO = [self.contentView viewWithTag:[unSelectIndexArr[j] integerValue] + 100];
                btnEnabledNO.enabled = NO;
                [btnEnabledNO setBackgroundImage:[UIImage imageNamed:@"station_bg"] forState:UIControlStateNormal];
                btnEnabledNO.backgroundColor = [UIColor whiteColor];
                [btnEnabledNO setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                if ([self.selectMuArr containsObject:[NSNumber numberWithInteger:i]]) {
                    [self.selectMuArr removeObject:[NSNumber numberWithInteger:i]];
                }
            }
        }
        
        //默认选择的时间段
        if (i==index) {
            UIButton *btnDefaultSelect = [self.contentView viewWithTag:i + 100];
            [btnDefaultSelect setBackgroundColor:[UIColor blueColor]];
            btnDefaultSelect.selected = YES;
            if (![self.selectMuArr containsObject:[NSNumber numberWithInteger:i]]) {
                [self.selectMuArr addObject:[NSNumber numberWithInteger:i]];
            }
        }
    }

}

- (void)clickedBtnWith:(UIButton *)btn{
    //多选
    [btn setBackgroundImage:nil forState:UIControlStateNormal];
    if (!btn.selected) {
        [btn setBackgroundColor:[UIColor blueColor]];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        if (![self.selectMuArr containsObject:[NSNumber numberWithInteger:btn.tag - 100]]) {
            NSNumber *index = [NSNumber numberWithInteger:btn.tag - 100];
            [self.selectMuArr addObject:index];
        }
    }else{
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if ([self.selectMuArr containsObject:[NSNumber numberWithInteger:btn.tag - 100]]) {
            NSNumber *index = [NSNumber numberWithInteger:btn.tag - 100];
            [self.selectMuArr removeObject:index];
        }
    }
    btn.selected = !btn.selected;
    
    [self.delegate selectIndexArr:self.selectMuArr];
    
}

@end
