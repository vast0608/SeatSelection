//
//  DataCell.m
//  SeatSelectionDemo
//
//  Created by 李晓璐 on 2018/11/3.
//  Copyright © 2018 LANEHUB. All rights reserved.
//

#import "DateCell.h"
#import "RadioBoxFun.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width

#define BUTTON_WIDTH (WIDTH-35)/4
#define BUTTON_HEIGHT (WIDTH-35)*2/17

@interface DateCell()

@property(nonatomic,strong)NSArray *buttonArr;

@end


@implementation DateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupContent];
        
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return self;
}
-(void)setupContent{
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 50, 17)];
    titleLabel.text = @"日期";
    [self.contentView addSubview:titleLabel];
    
    //日期的计算
    NSTimeInterval day = 24 * 60 * 60; //一天时间
    NSDate *thirdDay = [[NSDate alloc] initWithTimeIntervalSinceNow:day * 2];//后天
    NSDate *fourthDay = [[NSDate alloc] initWithTimeIntervalSinceNow:day * 3];//大后天
    NSDate *fifthDay = [[NSDate alloc] initWithTimeIntervalSinceNow:day * 4];//大大后天
    NSArray *dateArr = @[@"今天",@"明天",[self getTimes:thirdDay],[self getTimes:fourthDay],[self getTimes:fifthDay]];
    //单选布局
    RadioBoxFun *radioBox = [RadioBoxFun new];
    UIButton *btn0 =  [radioBox creatButton:CGRectMake(10, CGRectGetMaxY(titleLabel.frame)+15, BUTTON_WIDTH, BUTTON_HEIGHT) title:dateArr[0]];
    UIButton *btn1 =  [radioBox creatButton:CGRectMake(15+BUTTON_WIDTH, CGRectGetMaxY(titleLabel.frame)+15, BUTTON_WIDTH, BUTTON_HEIGHT) title:dateArr[1]];
    UIButton *btn2 =  [radioBox creatButton:CGRectMake(20+BUTTON_WIDTH*2, CGRectGetMaxY(titleLabel.frame)+15, BUTTON_WIDTH, BUTTON_HEIGHT) title:dateArr[2]];
    UIButton *btn3 =  [radioBox creatButton:CGRectMake(25+BUTTON_WIDTH*3, CGRectGetMaxY(titleLabel.frame)+15, BUTTON_WIDTH, BUTTON_HEIGHT) title:dateArr[3]];
    UIButton *btn4 =  [radioBox creatButton:CGRectMake(10, CGRectGetMaxY(btn0.frame)+15, BUTTON_WIDTH, BUTTON_HEIGHT) title:dateArr[4]];
    
    self.buttonArr = @[btn0,btn1,btn2,btn3,btn4];
    [radioBox radioBoxButtons:self.buttonArr  superView:self defultSelectedInde:self.buttonArr.count callBack:^(NSInteger selectIndex, NSString *title) {
        [self.delegate selectDateWidthValue:title index:selectIndex];
    }];
}
//计算日期
-(NSString*)getTimes:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM月dd日"];
    NSString *currentTimeString = [formatter stringFromDate:date];
    return currentTimeString;
}

-(void)setDefaultSelect:(NSInteger)index{
    UIButton *button = self.buttonArr[index];
    button.backgroundColor = [UIColor blueColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

@end
